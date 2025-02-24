// SPDX-License-Identifier: William Derenne for ethernalChain 2025
pragma solidity 0.8.26;

contract EthernalChain {

    // Variables privées pour stocker le nombre d'enregistrements, le montant et l'adresse root
    uint256 private nbRecords;
    uint256 private amount;
    address private addrRoot;
    bytes private id;

    // Mapping pour stocker les enregistrements
    mapping ( uint256 => bytes ) private records;

    // Modificateur pour vérifier que l'appelant est l'adresse root
    modifier IsRoot {
        require ( msg.sender == addrRoot, "!!! Not authorized !!!" );
        _;
    }

    // Modificateur pour vérifier que le contrat a des fonds
    modifier IsNotEmpty {
        require ( amount > 0, "!!! The contract has no funds !!!" );
        _;
    }

    // Evénements pour suivre les actions importantes
    event RecordSet ( uint256 indexed recordIndex, bytes record );
    event AmountWithdrawn ( address indexed to, uint256 amount );
    event ReceivedFunds ( address indexed from, uint256 amount );

    // Constructeur pour initialiser les variables
    constructor ( bytes memory _id ) payable {
        addrRoot = msg.sender;
        id = _id;
        nbRecords = 0;
        amount += msg.value;
    }

    // Fonction pour ajouter un enregistrement, seulement par l'adresse root et si des fonds sont présents
    function setRecord ( bytes calldata _record ) external IsRoot IsNotEmpty {
        records[nbRecords] = _record;
        emit RecordSet(nbRecords, _record); // Emission de l'événement
        ++nbRecords;
    }

    // Fonction pour retirer tous les fonds, seulement par l'adresse root et si des fonds sont présents
    function withdrawAmount() external IsRoot IsNotEmpty returns ( uint256 ) {
        uint256 _amount = amount;
        amount = 0;
        (bool success, ) = addrRoot.call{value: _amount}("");
        require(success, "!!! Transfer failed !!!");
        emit AmountWithdrawn(addrRoot, _amount); // Emission de l'événement
        return _amount;
    }

    // Fonction pour récupérer tous les enregistrements, seulement par l'adresse root
    function getRecords() external view IsRoot returns ( bytes[] memory ) {
        bytes[] memory _records = new bytes[]( nbRecords );
        for ( uint256 _i = 0; _i < nbRecords; ++_i ) {
            _records[_i] = records[_i];
        }
        return _records;
    }

    // Fonction pour obtenir le montant des fonds, seulement par l'adresse root
    function getAmount() external view IsRoot returns ( uint256 _amount ) {
        _amount = amount;
    }

    // Fonction pour obtenir l'identifiant du contrat, seulement par l'adresse root
    function getId() external view IsRoot returns ( bytes memory _id ) {
        _id = id;
    }

    // Fonction pour obtenir le nombre total d'enregistrements, seulement par l'adresse root
    function getNbRecords() external view IsRoot returns ( uint256 _nbrecords ) {
        _nbrecords = nbRecords;
    }

    // Fonction pour recevoir des fonds et les ajouter au montant
    receive() external payable {
        amount += msg.value;
        emit ReceivedFunds ( msg.sender, msg.value ); // Emission de l'événement
    }
}