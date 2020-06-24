pragma solidity ^0.5.12;

contract Phases{
    uint totalPhases;
    
    struct Phase {
        string phaseName;
        string location;
        bool active;
    }

    event NewPhase(string _name, string _location, uint _id);

    mapping(uint => Phase) public phaseHolder;
    constructor() public {}
    
    function createNewPhase(string memory _phasename, string memory _location) public returns(bool){
        totalPhases++;
        phaseHolder[totalPhases] = Phase(_phasename, _location, true);

        emit NewPhase(_phasename, _location, totalPhases);
        return true;
    }
    
    function isValidPhase(uint _phaseId) public view returns(bool){
        return phaseHolder[_phaseId].active;
    }
    
    function getPhaseInfo(uint _phaseId) public view returns(string memory, string memory, bool){
        return (phaseHolder[_phaseId].phaseName, phaseHolder[_phaseId].location, phaseHolder[_phaseId].active);
    }
    
    function getTotalPhases() public view returns(uint){
        return totalPhases;
    }
    
    function deactivatePhase(uint _Id) public returns(bool){
        phaseHolder[_Id].active = false;
        return true;
    }

}