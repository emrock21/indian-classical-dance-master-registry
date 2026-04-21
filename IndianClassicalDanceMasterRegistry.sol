// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract IndianClassicalDanceMasterRegistry {

    struct DanceStyle {
        string region;               // Tamil Nadu, Uttar Pradesh, Odisha, Kerala, etc.
        string lineageOrSchool;      // Kalakshetra, Jaipur Gharana, Lucknow Gharana, etc.
        string styleName;            // Bharatanatyam, Kathak, Odissi, Kuchipudi, etc.
        string materials;            // costumes, jewelry, instruments
        string technique;            // footwork, mudras, abhinaya, body posture
        string repertoire;           // varnams, thillanas, bols, pallavis, padams
        string uniqueness;           // what makes this school culturally distinct
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct StyleInput {
        string region;
        string lineageOrSchool;
        string styleName;
        string materials;
        string technique;
        string repertoire;
        string uniqueness;
    }

    DanceStyle[] public styles;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event StyleRecorded(
        uint256 indexed id,
        string styleName,
        string lineageOrSchool,
        address indexed creator
    );

    event StyleVoted(
        uint256 indexed id,
        bool like,
        uint256 likes,
        uint256 dislikes
    );

    constructor() {
        styles.push(
            DanceStyle({
                region: "India",
                lineageOrSchool: "ExampleSchool",
                styleName: "Example Style (replace with real entries)",
                materials: "example materials",
                technique: "example technique",
                repertoire: "example repertoire",
                uniqueness: "example uniqueness",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordStyle(StyleInput calldata s) external {
        styles.push(
            DanceStyle({
                region: s.region,
                lineageOrSchool: s.lineageOrSchool,
                styleName: s.styleName,
                materials: s.materials,
                technique: s.technique,
                repertoire: s.repertoire,
                uniqueness: s.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit StyleRecorded(
            styles.length - 1,
            s.styleName,
            s.lineageOrSchool,
            msg.sender
        );
    }

    function voteStyle(uint256 id, bool like) external {
        require(id < styles.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;

        DanceStyle storage d = styles[id];

        if (like) {
            d.likes += 1;
        } else {
            d.dislikes += 1;
        }

        emit StyleVoted(id, like, d.likes, d.dislikes);
    }

    function totalStyles() external view returns (uint256) {
        return styles.length;
    }
}
