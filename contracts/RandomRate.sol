// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RandomRate is Ownable {
    using Strings for string;
    using SafeMath for uint256;
    uint256 private constant NFT_TYPE = 0; //Kingdom
    uint256 private constant KINGDOM = 1; //Kingdom
    uint256 private constant TRANING_CAMP = 2; //Training Camp
    uint256 private constant GEAR = 3; //Battle Gear
    uint256 private constant DRO = 4; //Battle DRO
    uint256 private constant SUITE = 5; //Battle Suit
    uint256 private constant BOT = 6; //Battle Bot
    uint256 private constant GEN = 7; //Human GEN
    uint256 private constant WEAP = 8; //WEAP
    uint256 private constant COMBAT_RANKS = 9; //Combat Ranks
    uint256 private constant BLUEPRINT_COMM = 0;
    uint256 private constant BLUEPRINT_RARE = 1;
    uint256 private constant BLUEPRINT_EPIC = 2;
    uint256 private constant GENOMIC_COMMON = 3;
    uint256 private constant GENOMIC_RARE = 4;
    uint256 private constant GENOMIC_EPIC = 5;
    uint256 private constant SPACE_WARRIOR = 6;
    uint256 private constant COMMON_BOX = 0;
    uint256 private constant RARE_BOX = 1;
    uint256 private constant EPIC_BOX = 2;
    uint256 private constant SPECIAL_BOX = 3;
    uint256 private constant COMMON = 0;
    uint256 private constant RARE = 1;
    uint256 private constant EPIC = 2;

    //NFTPool
    mapping(uint256 => mapping(uint256 => uint256)) public NFTPool;

    //EPool
    mapping(uint256 => uint256) public EPool;

    //BlueprintFragmentPool
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256))))
        public BPPool;

    //GenPool
    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))
        public GenPool;

    //SpaceWarriorPool
    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256)))
        public SWPool;

    uint256 public NFTPoolCount;

    // function initialCommon() public onlyOwner {
    //     // ------- NFT Type ----------
    //     NFTPool[COMMON][0] = 0; //BLUEPRINT_COMM
    //     NFTPool[COMMON][1] = 0;
    //     NFTPool[COMMON][2] = 0;
    //     NFTPool[COMMON][3] = 0;
    //     NFTPool[COMMON][4] = 0;
    //     NFTPool[COMMON][5] = 0;
    //     NFTPool[COMMON][6] = 1; //BLUEPRINT_RARE
    //     NFTPool[COMMON][7] = 1;
    //     NFTPool[COMMON][8] = 1;
    //     NFTPool[COMMON][9] = 1;
    //     NFTPool[COMMON][10] = 3; //GENOMIC_COMMON
    //     NFTPool[COMMON][11] = 3;
    //     NFTPool[COMMON][12] = 3;
    //     NFTPool[COMMON][13] = 3;
    //     NFTPool[COMMON][14] = 3;
    //     NFTPool[COMMON][15] = 3;
    //     NFTPool[COMMON][16] = 3;
    //     NFTPool[COMMON][17] = 3;
    //     NFTPool[COMMON][18] = 6; //SPACE_WARRIOR
    //     NFTPool[COMMON][19] = 6;

    //     //-- Training Camp  ---
    //     SWPool[TRANING_CAMP][COMMON][0] = 0;
    //     SWPool[TRANING_CAMP][COMMON][1] = 1;
    //     SWPool[TRANING_CAMP][COMMON][2] = 2;
    //     SWPool[TRANING_CAMP][COMMON][3] = 3;
    //     SWPool[TRANING_CAMP][COMMON][4] = 4;

    //     //-- Gear COMMON COMMON---
    //     BPPool[COMMON][COMMON][GEAR][0] = 1;
    //     BPPool[COMMON][COMMON][GEAR][1] = 2;
    //     BPPool[COMMON][COMMON][GEAR][2] = 3;
    //     BPPool[COMMON][COMMON][GEAR][3] = 4;

    //     //-- Drone COMMON COMMON---
    //     BPPool[COMMON][COMMON][DRO][0] = 1;
    //     BPPool[COMMON][COMMON][DRO][1] = 2;
    //     BPPool[COMMON][COMMON][DRO][2] = 3;
    //     BPPool[COMMON][COMMON][DRO][3] = 4;

    //     //-- Suite COMMON COMMON---
    //     BPPool[COMMON][COMMON][SUITE][0] = 0;
    //     BPPool[COMMON][COMMON][SUITE][1] = 1;
    //     BPPool[COMMON][COMMON][SUITE][2] = 2;

    //     //-- Bot COMMON COMMON---
    //     BPPool[COMMON][COMMON][BOT][0] = 1;
    //     BPPool[COMMON][COMMON][BOT][1] = 2;
    //     BPPool[COMMON][COMMON][BOT][2] = 3;
    //     BPPool[COMMON][COMMON][BOT][3] = 4;

    //     //-- Weapon COMMON COMMON---
    //     BPPool[COMMON][COMMON][WEAP][0] = 0;
    //     BPPool[COMMON][COMMON][WEAP][1] = 1;
    //     BPPool[COMMON][COMMON][WEAP][2] = 2;
    //     BPPool[COMMON][COMMON][WEAP][3] = 3;

    //     //-- Genome  COMMON COMMON---
    //     GenPool[COMMON][COMMON][0] = 0;
    //     GenPool[COMMON][COMMON][1] = 1;
    //     GenPool[COMMON][COMMON][2] = 2;
    //     GenPool[COMMON][COMMON][3] = 3;
    //     GenPool[COMMON][COMMON][4] = 4;
    //     GenPool[COMMON][COMMON][5] = 5;
    //     GenPool[COMMON][COMMON][6] = 6;

    //     //-- Gear  COMMON RARE---
    //     BPPool[COMMON][RARE][GEAR][0] = 5;
    //     BPPool[COMMON][RARE][GEAR][1] = 6;
    //     BPPool[COMMON][RARE][GEAR][2] = 7;

    //     //-- Drone  COMMON RARE---
    //     BPPool[COMMON][RARE][DRO][0] = 5;
    //     BPPool[COMMON][RARE][DRO][1] = 6;
    //     BPPool[COMMON][RARE][DRO][2] = 7;

    //     //-- Suite  COMMON RARE---
    //     BPPool[COMMON][RARE][SUITE][0] = 3;
    //     BPPool[COMMON][RARE][SUITE][1] = 4;
    //     BPPool[COMMON][RARE][SUITE][2] = 5;

    //     //-- Bot  COMMON RARE---
    //     BPPool[COMMON][RARE][BOT][0] = 5;
    //     BPPool[COMMON][RARE][BOT][1] = 6;
    //     BPPool[COMMON][RARE][BOT][2] = 7;

    //     //-- Weapon  COMMON RARE---
    //     BPPool[COMMON][RARE][WEAP][0] = 4;
    //     BPPool[COMMON][RARE][WEAP][1] = 5;
    //     BPPool[COMMON][RARE][WEAP][2] = 6;
    //     BPPool[COMMON][RARE][WEAP][3] = 7;

    //     //Gear for Space warrior COMMON
    //     SWPool[GEAR][COMMON][0] = 0;
    //     SWPool[GEAR][COMMON][1] = 0;
    //     SWPool[GEAR][COMMON][2] = 0;
    //     SWPool[GEAR][COMMON][3] = 0;
    //     SWPool[GEAR][COMMON][4] = 0;
    //     SWPool[GEAR][COMMON][5] = 0;
    //     SWPool[GEAR][COMMON][6] = 0;
    //     SWPool[GEAR][COMMON][7] = 0;
    //     SWPool[GEAR][COMMON][8] = 0;
    //     SWPool[GEAR][COMMON][9] = 0;
    //     SWPool[GEAR][COMMON][10] = 0;
    //     SWPool[GEAR][COMMON][11] = 0;
    //     SWPool[GEAR][COMMON][12] = 0;
    //     SWPool[GEAR][COMMON][13] = 0;
    //     SWPool[GEAR][COMMON][14] = 0;
    //     SWPool[GEAR][COMMON][15] = 0;
    //     SWPool[GEAR][COMMON][16] = 0;
    //     SWPool[GEAR][COMMON][17] = 0;
    //     SWPool[GEAR][COMMON][18] = 0;
    //     SWPool[GEAR][COMMON][19] = 0;
    //     SWPool[GEAR][COMMON][20] = 0;
    //     SWPool[GEAR][COMMON][21] = 0;
    //     SWPool[GEAR][COMMON][22] = 0;
    //     SWPool[GEAR][COMMON][23] = 0;
    //     SWPool[GEAR][COMMON][24] = 1;
    //     SWPool[GEAR][COMMON][25] = 2;
    //     SWPool[GEAR][COMMON][26] = 3;
    //     SWPool[GEAR][COMMON][27] = 4;
    //     SWPool[GEAR][COMMON][28] = 5;
    //     SWPool[GEAR][COMMON][29] = 6;

    //      //Drone for Space warrior COMMON
    //     SWPool[DRO][COMMON][0] = 0;
    //     SWPool[DRO][COMMON][1] = 0;
    //     SWPool[DRO][COMMON][2] = 0;
    //     SWPool[DRO][COMMON][3] = 0;
    //     SWPool[DRO][COMMON][4] = 0;
    //     SWPool[DRO][COMMON][5] = 0;
    //     SWPool[DRO][COMMON][6] = 0;
    //     SWPool[DRO][COMMON][7] = 0;
    //     SWPool[DRO][COMMON][8] = 0;
    //     SWPool[DRO][COMMON][9] = 0;
    //     SWPool[DRO][COMMON][10] = 0;
    //     SWPool[DRO][COMMON][11] = 0;
    //     SWPool[DRO][COMMON][12] = 0;
    //     SWPool[DRO][COMMON][13] = 0;
    //     SWPool[DRO][COMMON][14] = 0;
    //     SWPool[DRO][COMMON][15] = 0;
    //     SWPool[DRO][COMMON][16] = 0;
    //     SWPool[DRO][COMMON][17] = 0;
    //     SWPool[DRO][COMMON][18] = 0;
    //     SWPool[DRO][COMMON][19] = 0;
    //     SWPool[DRO][COMMON][20] = 0;
    //     SWPool[DRO][COMMON][21] = 0;
    //     SWPool[DRO][COMMON][22] = 0;
    //     SWPool[DRO][COMMON][23] = 0;
    //     SWPool[DRO][COMMON][24] = 1;
    //     SWPool[DRO][COMMON][25] = 2;
    //     SWPool[DRO][COMMON][26] = 3;
    //     SWPool[DRO][COMMON][27] = 4;
    //     SWPool[DRO][COMMON][28] = 5;
    //     SWPool[DRO][COMMON][29] = 6;

    //    //Suite for Space warrior COMMON
    //     SWPool[SUITE][COMMON][0] = 0;
    //     SWPool[SUITE][COMMON][1] = 0;
    //     SWPool[SUITE][COMMON][2] = 0;
    //     SWPool[SUITE][COMMON][3] = 0;
    //     SWPool[SUITE][COMMON][4] = 0;
    //     SWPool[SUITE][COMMON][5] = 1;
    //     SWPool[SUITE][COMMON][6] = 1;
    //     SWPool[SUITE][COMMON][7] = 1;
    //     SWPool[SUITE][COMMON][8] = 1;
    //     SWPool[SUITE][COMMON][9] = 1;
    //     SWPool[SUITE][COMMON][10] = 2;
    //     SWPool[SUITE][COMMON][11] = 2;
    //     SWPool[SUITE][COMMON][12] = 2;
    //     SWPool[SUITE][COMMON][13] = 2;
    //     SWPool[SUITE][COMMON][14] = 2;
    //     SWPool[SUITE][COMMON][15] = 3;
    //     SWPool[SUITE][COMMON][16] = 4;
    //     SWPool[SUITE][COMMON][17] = 5;

    //    //Bot for Space warrior COMMON
    //     SWPool[BOT][COMMON][0] = 0;
    //     SWPool[BOT][COMMON][1] = 0;
    //     SWPool[BOT][COMMON][2] = 0;
    //     SWPool[BOT][COMMON][3] = 0;
    //     SWPool[BOT][COMMON][4] = 0;
    //     SWPool[BOT][COMMON][5] = 0;
    //     SWPool[BOT][COMMON][6] = 0;
    //     SWPool[BOT][COMMON][7] = 0;
    //     SWPool[BOT][COMMON][8] = 0;
    //     SWPool[BOT][COMMON][9] = 0;
    //     SWPool[BOT][COMMON][10] = 0;
    //     SWPool[BOT][COMMON][11] = 0;
    //     SWPool[BOT][COMMON][12] = 0;
    //     SWPool[BOT][COMMON][13] = 0;
    //     SWPool[BOT][COMMON][14] = 0;
    //     SWPool[BOT][COMMON][15] = 0;
    //     SWPool[BOT][COMMON][16] = 0;
    //     SWPool[BOT][COMMON][17] = 0;
    //     SWPool[BOT][COMMON][18] = 0;
    //     SWPool[BOT][COMMON][19] = 1;
    //     SWPool[BOT][COMMON][20] = 1;
    //     SWPool[BOT][COMMON][21] = 2;
    //     SWPool[BOT][COMMON][22] = 2;
    //     SWPool[BOT][COMMON][23] = 3;
    //     SWPool[BOT][COMMON][24] = 3;
    //     SWPool[BOT][COMMON][25] = 4;
    //     SWPool[BOT][COMMON][26] = 4;
    //     SWPool[BOT][COMMON][27] = 5;
    //     SWPool[BOT][COMMON][28] = 6;
    //     SWPool[BOT][COMMON][29] = 7;

    //     //Genome for Space warrior COMMON
    //     SWPool[GEN][COMMON][0] = 0;
    //     SWPool[GEN][COMMON][1] = 0;
    //     SWPool[GEN][COMMON][2] = 0;
    //     SWPool[GEN][COMMON][3] = 0;
    //     SWPool[GEN][COMMON][4] = 1;
    //     SWPool[GEN][COMMON][5] = 1;
    //     SWPool[GEN][COMMON][6] = 1;
    //     SWPool[GEN][COMMON][7] = 1;
    //     SWPool[GEN][COMMON][8] = 2;
    //     SWPool[GEN][COMMON][9] = 2;
    //     SWPool[GEN][COMMON][10] = 2;
    //     SWPool[GEN][COMMON][11] = 2;
    //     SWPool[GEN][COMMON][12] = 3;
    //     SWPool[GEN][COMMON][13] = 3;
    //     SWPool[GEN][COMMON][14] = 3;
    //     SWPool[GEN][COMMON][15] = 3;
    //     SWPool[GEN][COMMON][16] = 4;
    //     SWPool[GEN][COMMON][17] = 4;
    //     SWPool[GEN][COMMON][18] = 4;
    //     SWPool[GEN][COMMON][19] = 4;
    //     SWPool[GEN][COMMON][20] = 5;
    //     SWPool[GEN][COMMON][21] = 5;
    //     SWPool[GEN][COMMON][22] = 5;
    //     SWPool[GEN][COMMON][23] = 5;
    //     SWPool[GEN][COMMON][24] = 6;
    //     SWPool[GEN][COMMON][25] = 6;
    //     SWPool[GEN][COMMON][26] = 6;
    //     SWPool[GEN][COMMON][27] = 6;

    //     //Weapon for Space warrior COMMON
    //     SWPool[WEAP][COMMON][0] = 0;
    //     SWPool[WEAP][COMMON][1] = 0;
    //     SWPool[WEAP][COMMON][2] = 0;
    //     SWPool[WEAP][COMMON][3] = 0;
    //     SWPool[WEAP][COMMON][4] = 0;
    //     SWPool[WEAP][COMMON][5] = 0;
    //     SWPool[WEAP][COMMON][6] = 1;
    //     SWPool[WEAP][COMMON][7] = 1;
    //     SWPool[WEAP][COMMON][8] = 1;
    //     SWPool[WEAP][COMMON][9] = 1;
    //     SWPool[WEAP][COMMON][10] = 1;
    //     SWPool[WEAP][COMMON][11] = 1;
    //     SWPool[WEAP][COMMON][12] = 2;
    //     SWPool[WEAP][COMMON][13] = 2;
    //     SWPool[WEAP][COMMON][14] = 2;
    //     SWPool[WEAP][COMMON][15] = 2;
    //     SWPool[WEAP][COMMON][16] = 2;
    //     SWPool[WEAP][COMMON][17] = 2;
    //     SWPool[WEAP][COMMON][18] = 3;
    //     SWPool[WEAP][COMMON][19] = 3;
    //     SWPool[WEAP][COMMON][20] = 3;
    //     SWPool[WEAP][COMMON][21] = 3;
    //     SWPool[WEAP][COMMON][22] = 3;
    //     SWPool[WEAP][COMMON][23] = 3;
    //     SWPool[WEAP][COMMON][24] = 4;
    //     SWPool[WEAP][COMMON][25] = 5;
    //     SWPool[WEAP][COMMON][26] = 6;
    //     SWPool[WEAP][COMMON][27] = 7;
    //     SWPool[WEAP][COMMON][28] = 8;
    // }

    // function initialRare() public onlyOwner {
    //     // NFTPool - RARE
    //     // NFTPool[RARE][0] = 0;//BLUEPRINT_COMM
    //     // NFTPool[RARE][1] = 0;
    //     NFTPool[RARE][2] = 1; //BLUEPRINT_RARE
    //     NFTPool[RARE][3] = 1;
    //     NFTPool[RARE][4] = 2; //BLUEPRINT_EPIC
    //     NFTPool[RARE][5] = 3; //GENOMIC_COMMON
    //     NFTPool[RARE][6] = 3;
    //     NFTPool[RARE][7] = 3;
    //     NFTPool[RARE][8] = 3;
    //     NFTPool[RARE][9] = 4; //GENOMIC_RARE
    //     NFTPool[RARE][10] = 4;
    //     NFTPool[RARE][11] = 4;
    //     NFTPool[RARE][12] = 4;
    //     NFTPool[RARE][13] = 4;
    //     NFTPool[RARE][14] = 4;
    //     for (uint256 i = 15; i <= 19; i++) {
    //         NFTPool[RARE][i] = 6;
    //     }
    //     // NFTPool[RARE][15] = 6; //SPACE_WARRIOR
    //     // NFTPool[RARE][16] = 6;
    //     // NFTPool[RARE][17] = 6;
    //     // NFTPool[RARE][18] = 6;
    //     // NFTPool[RARE][19] = 6;

    //     // SWPool[TRANING_CAMP][RARE][0] = 0;
    //     SWPool[TRANING_CAMP][RARE][1] = 1;
    //     SWPool[TRANING_CAMP][RARE][2] = 2;
    //     SWPool[TRANING_CAMP][RARE][3] = 3;
    //     SWPool[TRANING_CAMP][RARE][4] = 4;

    //     // --- For  Rare Box ------
    //     BPPool[RARE][COMMON][GEAR][0] = 1;
    //     BPPool[RARE][COMMON][GEAR][1] = 2;
    //     BPPool[RARE][COMMON][GEAR][2] = 3;
    //     BPPool[RARE][COMMON][GEAR][3] = 4;

    //     BPPool[RARE][COMMON][DRO][0] = 1;
    //     BPPool[RARE][COMMON][DRO][1] = 2;
    //     BPPool[RARE][COMMON][DRO][2] = 3;
    //     BPPool[RARE][COMMON][DRO][3] = 4;

    //     // BPPool[RARE][COMMON][SUITE][0] = 0;
    //     BPPool[RARE][COMMON][SUITE][1] = 1;
    //     BPPool[RARE][COMMON][SUITE][2] = 2;

    //     BPPool[RARE][COMMON][BOT][0] = 1;
    //     BPPool[RARE][COMMON][BOT][1] = 2;
    //     BPPool[RARE][COMMON][BOT][2] = 3;
    //     BPPool[RARE][COMMON][BOT][3] = 4;

    //     // BPPool[RARE][COMMON][WEAP][0] = 0;
    //     BPPool[RARE][COMMON][WEAP][1] = 1;
    //     BPPool[RARE][COMMON][WEAP][2] = 2;
    //     BPPool[RARE][COMMON][WEAP][3] = 3;
    //     //
    //     BPPool[RARE][RARE][GEAR][0] = 5;
    //     BPPool[RARE][RARE][GEAR][1] = 6;
    //     BPPool[RARE][RARE][GEAR][2] = 7;

    //     BPPool[RARE][RARE][DRO][0] = 5;
    //     BPPool[RARE][RARE][DRO][1] = 6;
    //     BPPool[RARE][RARE][DRO][2] = 7;

    //     BPPool[RARE][RARE][SUITE][0] = 3;
    //     BPPool[RARE][RARE][SUITE][1] = 4;
    //     BPPool[RARE][RARE][SUITE][2] = 5;

    //     BPPool[RARE][RARE][BOT][0] = 5;
    //     BPPool[RARE][RARE][BOT][1] = 6;
    //     BPPool[RARE][RARE][BOT][2] = 7;

    //     BPPool[RARE][RARE][WEAP][0] = 4;
    //     BPPool[RARE][RARE][WEAP][1] = 5;
    //     BPPool[RARE][RARE][WEAP][2] = 6;
    //     BPPool[RARE][RARE][WEAP][3] = 7;
    //     BPPool[RARE][RARE][WEAP][4] = 8;

    //     //Epic
    //     BPPool[RARE][EPIC][GEAR][0] = 8;
    //     BPPool[RARE][EPIC][GEAR][1] = 9;
    //     BPPool[RARE][EPIC][GEAR][2] = 10;

    //     BPPool[RARE][EPIC][DRO][0] = 8;
    //     BPPool[RARE][EPIC][DRO][1] = 9;
    //     BPPool[RARE][EPIC][DRO][2] = 10;

    //     BPPool[RARE][EPIC][SUITE][0] = 6;
    //     BPPool[RARE][EPIC][SUITE][1] = 7;
    //     BPPool[RARE][EPIC][SUITE][2] = 8;
    //     BPPool[RARE][EPIC][SUITE][3] = 9;

    //     BPPool[RARE][EPIC][BOT][0] = 8;
    //     BPPool[RARE][EPIC][BOT][1] = 9;
    //     BPPool[RARE][EPIC][BOT][2] = 10;

    //     BPPool[RARE][EPIC][WEAP][0] = 9;
    //     BPPool[RARE][EPIC][WEAP][1] = 10;
    //     BPPool[RARE][EPIC][WEAP][2] = 11;
    //     BPPool[RARE][EPIC][WEAP][3] = 12;
    //     BPPool[RARE][EPIC][WEAP][4] = 13;
    //     BPPool[RARE][EPIC][WEAP][5] = 14;

    //     // GenPool[RARE][COMMON][0] = 0;
    //     GenPool[RARE][COMMON][1] = 1;
    //     GenPool[RARE][COMMON][2] = 2;
    //     GenPool[RARE][COMMON][3] = 3;
    //     GenPool[RARE][COMMON][4] = 4;
    //     GenPool[RARE][COMMON][5] = 5;
    //     GenPool[RARE][COMMON][6] = 6;

    //     GenPool[RARE][RARE][0] = 7;
    //     GenPool[RARE][RARE][1] = 8;
    //     GenPool[RARE][RARE][2] = 9;
    //     GenPool[RARE][RARE][3] = 10;
    //     GenPool[RARE][RARE][4] = 11;
    //     GenPool[RARE][RARE][5] = 12;

    //     //BattleGearCampPool
    //     // SWPool[GEAR][RARE][0] = 0;
    //     // SWPool[GEAR][RARE][1] = 0;
    //     // SWPool[GEAR][RARE][2] = 0;
    //     // SWPool[GEAR][RARE][3] = 0;
    //     // SWPool[GEAR][RARE][4] = 0;
    //     // SWPool[GEAR][RARE][5] = 0;
    //     // SWPool[GEAR][RARE][6] = 0;
    //     // SWPool[GEAR][RARE][7] = 0;
    //     // SWPool[GEAR][RARE][8] = 0;
    //     // SWPool[GEAR][RARE][9] = 0;
    //     // SWPool[GEAR][RARE][10] = 0;
    //     // SWPool[GEAR][RARE][11] = 0;
    //     // SWPool[GEAR][RARE][12] = 0;
    //     // SWPool[GEAR][RARE][13] = 0;
    //     // SWPool[GEAR][RARE][14] = 0;
    //     // SWPool[GEAR][RARE][15] = 0;
    //     // SWPool[GEAR][RARE][16] = 0;
    //     // SWPool[GEAR][RARE][17] = 0;
    //     // SWPool[GEAR][RARE][18] = 0;
    //     // SWPool[GEAR][RARE][19] = 0;
    //     SWPool[GEAR][RARE][20] = 1;
    //     SWPool[GEAR][RARE][21] = 2;
    //     SWPool[GEAR][RARE][22] = 3;
    //     SWPool[GEAR][RARE][23] = 4;
    //     SWPool[GEAR][RARE][24] = 5;
    //     SWPool[GEAR][RARE][25] = 6;
    //     SWPool[GEAR][RARE][26] = 7;
    //     SWPool[GEAR][RARE][27] = 8;
    //     SWPool[GEAR][RARE][28] = 9;
    //     SWPool[GEAR][RARE][29] = 10;

    //     //DRO
    //     // SWPool[DRO][RARE][0] = 0;
    //     // SWPool[DRO][RARE][1] = 0;
    //     // SWPool[DRO][RARE][2] = 0;
    //     // SWPool[DRO][RARE][3] = 0;
    //     // SWPool[DRO][RARE][4] = 0;
    //     // SWPool[DRO][RARE][5] = 0;
    //     // SWPool[DRO][RARE][6] = 0;
    //     // SWPool[DRO][RARE][7] = 0;
    //     // SWPool[DRO][RARE][8] = 0;
    //     // SWPool[DRO][RARE][9] = 0;
    //     // SWPool[DRO][RARE][10] = 0;
    //     // SWPool[DRO][RARE][11] = 0;
    //     // SWPool[DRO][RARE][12] = 0;
    //     // SWPool[DRO][RARE][13] = 0;
    //     // SWPool[DRO][RARE][14] = 0;
    //     // SWPool[DRO][RARE][15] = 0;
    //     // SWPool[DRO][RARE][16] = 0;
    //     // SWPool[DRO][RARE][17] = 0;
    //     // SWPool[DRO][RARE][18] = 0;
    //     // SWPool[DRO][RARE][19] = 0;
    //     SWPool[DRO][RARE][20] = 1;
    //     SWPool[DRO][RARE][21] = 2;
    //     SWPool[DRO][RARE][22] = 3;
    //     SWPool[DRO][RARE][23] = 4;
    //     SWPool[DRO][RARE][24] = 5;
    //     SWPool[DRO][RARE][25] = 6;
    //     SWPool[DRO][RARE][26] = 7;
    //     SWPool[DRO][RARE][27] = 8;
    //     SWPool[DRO][RARE][28] = 9;
    //     SWPool[DRO][RARE][29] = 10;

    //     //SUITE
    //     // SWPool[SUITE][RARE][0] = 0;
    //     // SWPool[SUITE][RARE][1] = 0;
    //     // SWPool[SUITE][RARE][2] = 0;
    //     SWPool[SUITE][RARE][3] = 1;
    //     SWPool[SUITE][RARE][4] = 1;
    //     SWPool[SUITE][RARE][5] = 1;
    //     SWPool[SUITE][RARE][6] = 2;
    //     SWPool[SUITE][RARE][7] = 2;
    //     SWPool[SUITE][RARE][8] = 2;
    //     SWPool[SUITE][RARE][9] = 4;
    //     SWPool[SUITE][RARE][10] = 4;
    //     SWPool[SUITE][RARE][11] = 5;
    //     SWPool[SUITE][RARE][12] = 5;
    //     SWPool[SUITE][RARE][13] = 6;
    //     SWPool[SUITE][RARE][14] = 7;
    //     SWPool[SUITE][RARE][15] = 8;
    //     SWPool[SUITE][RARE][16] = 9;

    //     //BOT
    //     // SWPool[BOT][RARE][0] = 0;
    //     // SWPool[BOT][RARE][1] = 0;
    //     // SWPool[BOT][RARE][2] = 0;
    //     // SWPool[BOT][RARE][3] = 0;
    //     // SWPool[BOT][RARE][4] = 0;
    //     // SWPool[BOT][RARE][5] = 0;
    //     // SWPool[BOT][RARE][6] = 0;
    //     // SWPool[BOT][RARE][7] = 0;
    //     // SWPool[BOT][RARE][8] = 0;
    //     // SWPool[BOT][RARE][9] = 0;
    //     // SWPool[BOT][RARE][10] = 0;
    //     // SWPool[BOT][RARE][11] = 0;
    //     // SWPool[BOT][RARE][12] = 0;
    //     // SWPool[BOT][RARE][13] = 0;
    //     // SWPool[BOT][RARE][14] = 0;
    //     // SWPool[BOT][RARE][15] = 0;
    //     // SWPool[BOT][RARE][16] = 0;
    //     // SWPool[BOT][RARE][17] = 0;
    //     SWPool[BOT][RARE][18] = 1;
    //     SWPool[BOT][RARE][19] = 1;
    //     SWPool[BOT][RARE][20] = 2;
    //     SWPool[BOT][RARE][21] = 2;
    //     SWPool[BOT][RARE][22] = 4;
    //     SWPool[BOT][RARE][23] = 4;
    //     SWPool[BOT][RARE][24] = 5;
    //     SWPool[BOT][RARE][25] = 6;
    //     SWPool[BOT][RARE][26] = 7;
    //     SWPool[BOT][RARE][27] = 8;
    //     SWPool[BOT][RARE][28] = 9;
    //     SWPool[BOT][RARE][29] = 10;

    //     //GEN
    //     // SWPool[GEN][RARE][0] = 0;
    //     // SWPool[GEN][RARE][1] = 0;
    //     // SWPool[GEN][RARE][2] = 0;
    //     SWPool[GEN][RARE][3] = 1;
    //     SWPool[GEN][RARE][4] = 1;
    //     SWPool[GEN][RARE][5] = 1;
    //     SWPool[GEN][RARE][6] = 2;
    //     SWPool[GEN][RARE][7] = 2;
    //     SWPool[GEN][RARE][8] = 2;
    //     SWPool[GEN][RARE][9] = 3;
    //     SWPool[GEN][RARE][10] = 3;
    //     SWPool[GEN][RARE][11] = 3;
    //     SWPool[GEN][RARE][12] = 4;
    //     SWPool[GEN][RARE][13] = 4;
    //     SWPool[GEN][RARE][14] = 4;
    //     SWPool[GEN][RARE][15] = 5;
    //     SWPool[GEN][RARE][16] = 5;
    //     SWPool[GEN][RARE][17] = 5;
    //     SWPool[GEN][RARE][18] = 6;
    //     SWPool[GEN][RARE][19] = 6;
    //     SWPool[GEN][RARE][20] = 6;
    //     SWPool[GEN][RARE][21] = 7;
    //     SWPool[GEN][RARE][22] = 8;
    //     SWPool[GEN][RARE][23] = 9;
    //     SWPool[GEN][RARE][24] = 10;

    //     //WEAP
    //     // SWPool[WEAP][RARE][0] = 0;
    //     // SWPool[WEAP][RARE][1] = 0;
    //     // SWPool[WEAP][RARE][2] = 0;
    //     // SWPool[WEAP][RARE][3] = 0;
    //     // SWPool[WEAP][RARE][4] = 0;
    //     for (uint256 i = 5; i <= 10; i++) {
    //         SWPool[WEAP][RARE][i] = 1;
    //     }
    //     // SWPool[WEAP][RARE][5] = 1;
    //     // SWPool[WEAP][RARE][6] = 1;
    //     // SWPool[WEAP][RARE][7] = 1;
    //     // SWPool[WEAP][RARE][8] = 1;
    //     // SWPool[WEAP][RARE][9] = 1;
    //     // SWPool[WEAP][RARE][10] = 1;
    //     SWPool[WEAP][RARE][11] = 2;
    //     SWPool[WEAP][RARE][12] = 2;
    //     SWPool[WEAP][RARE][13] = 2;
    //     SWPool[WEAP][RARE][14] = 2;
    //     SWPool[WEAP][RARE][15] = 2;
    //     SWPool[WEAP][RARE][16] = 2;
    //     SWPool[WEAP][RARE][17] = 3;
    //     SWPool[WEAP][RARE][18] = 3;
    //     SWPool[WEAP][RARE][19] = 3;
    //     SWPool[WEAP][RARE][20] = 3;
    //     SWPool[WEAP][RARE][21] = 3;
    //     SWPool[WEAP][RARE][22] = 3;
    //     SWPool[WEAP][RARE][23] = 4;
    //     SWPool[WEAP][RARE][24] = 5;
    //     SWPool[WEAP][RARE][25] = 6;
    //     SWPool[WEAP][RARE][26] = 7;
    //     SWPool[WEAP][RARE][27] = 8;
    //     SWPool[WEAP][RARE][28] = 9;
    //     SWPool[WEAP][RARE][29] = 10;
    //     SWPool[WEAP][RARE][30] = 11;
    //     SWPool[WEAP][RARE][31] = 12;
    //     SWPool[WEAP][RARE][32] = 13;
    //     SWPool[WEAP][RARE][33] = 14;
    // }

    // function initialSp() public onlyOwner {
    //     NFTPool[EPIC][0] = 2; //BLUEPRINT_EPIC
    //     NFTPool[EPIC][1] = 2;
    //     NFTPool[EPIC][2] = 4; //GENOMIC_RARE
    //     NFTPool[EPIC][3] = 4;
    //     NFTPool[EPIC][4] = 5; //GENOMIC_EPIC
    //     NFTPool[EPIC][5] = 5;
    //     for (uint256 i = 6; i <= 19; i++) {
    //         NFTPool[EPIC][i] = 6;
    //     }

    //     // NFTPool[EPIC][6] = 6; //SPACE_WARRIOR
    //     // NFTPool[EPIC][7] = 6;
    //     // NFTPool[EPIC][8] = 6;
    //     // NFTPool[EPIC][9] = 6;
    //     // NFTPool[EPIC][10] = 6;
    //     // NFTPool[EPIC][11] = 6;
    //     // NFTPool[EPIC][12] = 6;
    //     // NFTPool[EPIC][13] = 6;
    //     // NFTPool[EPIC][14] = 6;
    //     // NFTPool[EPIC][15] = 6;
    //     // NFTPool[EPIC][16] = 6;
    //     // NFTPool[EPIC][17] = 6;
    //     // NFTPool[EPIC][18] = 6;
    //     // NFTPool[EPIC][19] = 6;

    //     // SWPool[TRANING_CAMP][EPIC][0] = 0;
    //     SWPool[TRANING_CAMP][EPIC][1] = 1;
    //     SWPool[TRANING_CAMP][EPIC][2] = 2;
    //     SWPool[TRANING_CAMP][EPIC][3] = 3;
    //     SWPool[TRANING_CAMP][EPIC][4] = 4;

    //     // --- For Epic Box ------
    //     BPPool[EPIC][RARE][GEAR][0] = 8;
    //     BPPool[EPIC][RARE][GEAR][1] = 9;
    //     BPPool[EPIC][RARE][GEAR][2] = 10;

    //     BPPool[EPIC][RARE][DRO][0] = 8;
    //     BPPool[EPIC][RARE][DRO][1] = 9;
    //     BPPool[EPIC][RARE][DRO][2] = 10;

    //     BPPool[EPIC][RARE][SUITE][0] = 6;
    //     BPPool[EPIC][RARE][SUITE][1] = 7;
    //     BPPool[EPIC][RARE][SUITE][2] = 8;
    //     BPPool[EPIC][RARE][SUITE][3] = 9;

    //     BPPool[EPIC][RARE][BOT][0] = 8;
    //     BPPool[EPIC][RARE][BOT][1] = 9;
    //     BPPool[EPIC][RARE][BOT][2] = 10;

    //     BPPool[EPIC][RARE][WEAP][0] = 9;
    //     BPPool[EPIC][RARE][WEAP][1] = 10;
    //     BPPool[EPIC][RARE][WEAP][2] = 11;
    //     BPPool[EPIC][RARE][WEAP][3] = 12;
    //     BPPool[EPIC][RARE][WEAP][4] = 13;
    //     BPPool[EPIC][RARE][WEAP][5] = 14;

    //     //Epic
    //     BPPool[EPIC][EPIC][GEAR][0] = 8;
    //     BPPool[EPIC][EPIC][GEAR][1] = 9;
    //     BPPool[EPIC][EPIC][GEAR][2] = 10;

    //     BPPool[EPIC][EPIC][DRO][0] = 8;
    //     BPPool[EPIC][EPIC][DRO][1] = 9;
    //     BPPool[EPIC][EPIC][DRO][2] = 10;

    //     BPPool[EPIC][EPIC][SUITE][0] = 6;
    //     BPPool[EPIC][EPIC][SUITE][1] = 7;
    //     BPPool[EPIC][EPIC][SUITE][2] = 8;
    //     BPPool[EPIC][EPIC][SUITE][3] = 9;

    //     BPPool[EPIC][EPIC][BOT][0] = 8;
    //     BPPool[EPIC][EPIC][BOT][1] = 9;
    //     BPPool[EPIC][EPIC][BOT][2] = 10;

    //     BPPool[EPIC][EPIC][WEAP][0] = 9;
    //     BPPool[EPIC][EPIC][WEAP][1] = 10;
    //     BPPool[EPIC][EPIC][WEAP][2] = 11;
    //     BPPool[EPIC][EPIC][WEAP][3] = 12;
    //     BPPool[EPIC][EPIC][WEAP][4] = 13;
    //     BPPool[EPIC][EPIC][WEAP][5] = 14;

    //     // GenPool[EPIC][COMMON][0] = 0;
    //     // GenPool[EPIC][COMMON][1] = 1;
    //     // GenPool[EPIC][COMMON][2] = 2;
    //     // GenPool[EPIC][COMMON][3] = 3;
    //     // GenPool[EPIC][COMMON][4] = 4;
    //     // GenPool[EPIC][COMMON][5] = 5;
    //     // GenPool[EPIC][COMMON][6] = 6;

    //     GenPool[EPIC][RARE][0] = 7;
    //     GenPool[EPIC][RARE][1] = 8;
    //     GenPool[EPIC][RARE][2] = 9;
    //     GenPool[EPIC][RARE][3] = 10;
    //     GenPool[EPIC][RARE][4] = 11;
    //     GenPool[EPIC][RARE][5] = 12;

    //     GenPool[EPIC][EPIC][0] = 13;
    //     GenPool[EPIC][EPIC][1] = 14;
    //     GenPool[EPIC][EPIC][2] = 15;
    //     GenPool[EPIC][EPIC][3] = 16;

    //     //BattleGearCampPool
    //     // SWPool[GEAR][EPIC][0] = 0;
    //     // SWPool[GEAR][EPIC][1] = 0;
    //     // SWPool[GEAR][EPIC][2] = 0;
    //     // SWPool[GEAR][EPIC][3] = 0;
    //     // SWPool[GEAR][EPIC][4] = 0;
    //     // SWPool[GEAR][EPIC][5] = 0;
    //     // SWPool[GEAR][EPIC][6] = 0;
    //     // SWPool[GEAR][EPIC][7] = 0;
    //     // SWPool[GEAR][EPIC][8] = 0;
    //     // SWPool[GEAR][EPIC][9] = 0;
    //     // SWPool[GEAR][EPIC][10] = 0;
    //     // SWPool[GEAR][EPIC][11] = 0;
    //     // SWPool[GEAR][EPIC][12] = 0;
    //     // SWPool[GEAR][EPIC][13] = 0;
    //     // SWPool[GEAR][EPIC][14] = 0;
    //     // SWPool[GEAR][EPIC][15] = 0;
    //     SWPool[GEAR][EPIC][16] = 1;
    //     SWPool[GEAR][EPIC][17] = 1;
    //     SWPool[GEAR][EPIC][18] = 2;
    //     SWPool[GEAR][EPIC][19] = 2;
    //     SWPool[GEAR][EPIC][20] = 3;
    //     SWPool[GEAR][EPIC][21] = 3;
    //     SWPool[GEAR][EPIC][22] = 4;
    //     SWPool[GEAR][EPIC][23] = 4;
    //     SWPool[GEAR][EPIC][24] = 5;
    //     SWPool[GEAR][EPIC][25] = 6;
    //     SWPool[GEAR][EPIC][26] = 7;
    //     SWPool[GEAR][EPIC][27] = 8;
    //     SWPool[GEAR][EPIC][28] = 9;
    //     SWPool[GEAR][EPIC][29] = 10;

    //     //DRO
    //     // SWPool[DRO][EPIC][0] = 0;
    //     // SWPool[DRO][EPIC][1] = 0;
    //     // SWPool[DRO][EPIC][2] = 0;
    //     // SWPool[DRO][EPIC][3] = 0;
    //     // SWPool[DRO][EPIC][4] = 0;
    //     // SWPool[DRO][EPIC][5] = 0;
    //     // SWPool[DRO][EPIC][6] = 0;
    //     // SWPool[DRO][EPIC][7] = 0;
    //     // SWPool[DRO][EPIC][8] = 0;
    //     // SWPool[DRO][EPIC][9] = 0;
    //     // SWPool[DRO][EPIC][10] = 0;
    //     // SWPool[DRO][EPIC][11] = 0;
    //     // SWPool[DRO][EPIC][12] = 0;
    //     // SWPool[DRO][EPIC][13] = 0;
    //     // SWPool[DRO][EPIC][14] = 0;
    //     // SWPool[DRO][EPIC][15] = 0;
    //     SWPool[DRO][EPIC][16] = 1;
    //     SWPool[DRO][EPIC][17] = 1;
    //     SWPool[DRO][EPIC][18] = 2;
    //     SWPool[DRO][EPIC][19] = 2;
    //     SWPool[DRO][EPIC][20] = 3;
    //     SWPool[DRO][EPIC][21] = 3;
    //     SWPool[DRO][EPIC][22] = 4;
    //     SWPool[DRO][EPIC][23] = 4;
    //     SWPool[DRO][EPIC][24] = 5;
    //     SWPool[DRO][EPIC][25] = 6;
    //     SWPool[DRO][EPIC][26] = 7;
    //     SWPool[DRO][EPIC][27] = 8;
    //     SWPool[DRO][EPIC][28] = 9;
    //     SWPool[DRO][EPIC][29] = 10;

    //     //SUITE
    //     // SWPool[SUITE][EPIC][0] = 0;
    //     // SWPool[SUITE][EPIC][1] = 0;
    //     // SWPool[SUITE][EPIC][2] = 0;
    //     // SWPool[SUITE][EPIC][3] = 0;
    //     SWPool[SUITE][EPIC][4] = 1;
    //     SWPool[SUITE][EPIC][5] = 1;
    //     SWPool[SUITE][EPIC][6] = 1;
    //     SWPool[SUITE][EPIC][7] = 1;
    //     SWPool[SUITE][EPIC][8] = 2;
    //     SWPool[SUITE][EPIC][9] = 2;
    //     SWPool[SUITE][EPIC][10] = 2;
    //     SWPool[SUITE][EPIC][11] = 2;
    //     SWPool[SUITE][EPIC][12] = 3;
    //     SWPool[SUITE][EPIC][13] = 4;
    //     SWPool[SUITE][EPIC][14] = 5;
    //     SWPool[SUITE][EPIC][15] = 6;
    //     SWPool[SUITE][EPIC][16] = 7;
    //     SWPool[SUITE][EPIC][17] = 8;
    //     SWPool[SUITE][EPIC][18] = 9;

    //     //BOT
    //     // SWPool[BOT][EPIC][0] = 0;
    //     // SWPool[BOT][EPIC][1] = 0;
    //     // SWPool[BOT][EPIC][2] = 0;
    //     // SWPool[BOT][EPIC][3] = 0;
    //     // SWPool[BOT][EPIC][4] = 0;
    //     // SWPool[BOT][EPIC][5] = 0;
    //     // SWPool[BOT][EPIC][6] = 0;
    //     // SWPool[BOT][EPIC][7] = 0;
    //     // SWPool[BOT][EPIC][8] = 0;
    //     // SWPool[BOT][EPIC][9] = 0;
    //     // SWPool[BOT][EPIC][10] = 0;
    //     // SWPool[BOT][EPIC][11] = 0;
    //     // SWPool[BOT][EPIC][12] = 0;
    //     // SWPool[BOT][EPIC][13] = 0;
    //     // SWPool[BOT][EPIC][14] = 0;
    //     // SWPool[BOT][EPIC][15] = 0;
    //     // SWPool[BOT][EPIC][16] = 0;
    //     // SWPool[BOT][EPIC][17] = 0;
    //     SWPool[BOT][EPIC][18] = 1;
    //     SWPool[BOT][EPIC][19] = 1;
    //     SWPool[BOT][EPIC][20] = 2;
    //     SWPool[BOT][EPIC][21] = 2;
    //     SWPool[BOT][EPIC][22] = 4;
    //     SWPool[BOT][EPIC][23] = 4;
    //     SWPool[BOT][EPIC][24] = 5;
    //     SWPool[BOT][EPIC][25] = 6;
    //     SWPool[BOT][EPIC][26] = 7;
    //     SWPool[BOT][EPIC][27] = 8;
    //     SWPool[BOT][EPIC][28] = 9;
    //     SWPool[BOT][EPIC][29] = 10;

    //     //GEN
    //     // SWPool[GEN][EPIC][0] = 0;
    //     // SWPool[GEN][EPIC][1] = 0;
    //     // SWPool[GEN][EPIC][2] = 0;
    //     SWPool[GEN][EPIC][3] = 1;
    //     SWPool[GEN][EPIC][4] = 1;
    //     SWPool[GEN][EPIC][5] = 1;
    //     SWPool[GEN][EPIC][6] = 2;
    //     SWPool[GEN][EPIC][7] = 2;
    //     SWPool[GEN][EPIC][8] = 2;
    //     SWPool[GEN][EPIC][9] = 3;
    //     SWPool[GEN][EPIC][10] = 3;
    //     SWPool[GEN][EPIC][11] = 3;
    //     SWPool[GEN][EPIC][12] = 4;
    //     SWPool[GEN][EPIC][13] = 4;
    //     SWPool[GEN][EPIC][14] = 4;
    //     SWPool[GEN][EPIC][15] = 5;
    //     SWPool[GEN][EPIC][16] = 5;
    //     SWPool[GEN][EPIC][17] = 6;
    //     SWPool[GEN][EPIC][18] = 6;
    //     SWPool[GEN][EPIC][19] = 7;
    //     SWPool[GEN][EPIC][20] = 8;
    //     SWPool[GEN][EPIC][21] = 9;
    //     SWPool[GEN][EPIC][22] = 10;
    //     SWPool[GEN][EPIC][23] = 11;
    //     SWPool[GEN][EPIC][24] = 12;
    //     SWPool[GEN][EPIC][25] = 13;
    //     SWPool[GEN][EPIC][26] = 14;
    //     SWPool[GEN][EPIC][27] = 15;
    //     SWPool[GEN][EPIC][28] = 16;

    //     //WEAP
    //     // SWPool[WEAP][RARE][0] = 0;
    //     // SWPool[WEAP][RARE][1] = 0;
    //     // SWPool[WEAP][RARE][2] = 0;
    //     // SWPool[WEAP][RARE][3] = 0;
    //     SWPool[WEAP][RARE][4] = 1;
    //     SWPool[WEAP][RARE][5] = 1;
    //     SWPool[WEAP][RARE][6] = 1;
    //     SWPool[WEAP][RARE][7] = 1;
    //     SWPool[WEAP][RARE][8] = 2;
    //     SWPool[WEAP][RARE][9] = 2;
    //     SWPool[WEAP][RARE][10] = 2;
    //     SWPool[WEAP][RARE][11] = 2;
    //     SWPool[WEAP][RARE][12] = 3;
    //     SWPool[WEAP][RARE][13] = 3;
    //     SWPool[WEAP][RARE][14] = 3;
    //     SWPool[WEAP][RARE][15] = 3;
    //     SWPool[WEAP][RARE][16] = 4;
    //     SWPool[WEAP][RARE][17] = 4;
    //     SWPool[WEAP][RARE][18] = 5;
    //     SWPool[WEAP][RARE][19] = 5;
    //     SWPool[WEAP][RARE][20] = 6;
    //     SWPool[WEAP][RARE][21] = 6;
    //     SWPool[WEAP][RARE][22] = 7;
    //     SWPool[WEAP][RARE][23] = 7;
    //     SWPool[WEAP][RARE][24] = 8;
    //     SWPool[WEAP][RARE][25] = 8;
    //     SWPool[WEAP][RARE][26] = 9;
    //     SWPool[WEAP][RARE][27] = 10;
    //     SWPool[WEAP][RARE][28] = 11;
    //     SWPool[WEAP][RARE][29] = 12;
    //     SWPool[WEAP][RARE][30] = 13;
    //     SWPool[WEAP][RARE][31] = 14;
    // }

    // function initialEpic() public onlyOwner {
    //     NFTPool[EPIC][0] = 2; //BLUEPRINT_EPIC
    //     NFTPool[EPIC][1] = 2;
    //     NFTPool[EPIC][2] = 4; //GENOMIC_RARE
    //     NFTPool[EPIC][3] = 4;
    //     NFTPool[EPIC][4] = 5; //GENOMIC_EPIC
    //     NFTPool[EPIC][5] = 5;
    //     for (uint256 i = 6; i <= 19; i++) {
    //         NFTPool[EPIC][i] = 6;
    //     }

    //     // NFTPool[EPIC][6] = 6; //SPACE_WARRIOR
    //     // NFTPool[EPIC][7] = 6;
    //     // NFTPool[EPIC][8] = 6;
    //     // NFTPool[EPIC][9] = 6;
    //     // NFTPool[EPIC][10] = 6;
    //     // NFTPool[EPIC][11] = 6;
    //     // NFTPool[EPIC][12] = 6;
    //     // NFTPool[EPIC][13] = 6;
    //     // NFTPool[EPIC][14] = 6;
    //     // NFTPool[EPIC][15] = 6;
    //     // NFTPool[EPIC][16] = 6;
    //     // NFTPool[EPIC][17] = 6;
    //     // NFTPool[EPIC][18] = 6;
    //     // NFTPool[EPIC][19] = 6;

    //     // SWPool[TRANING_CAMP][EPIC][0] = 0;
    //     SWPool[TRANING_CAMP][EPIC][1] = 1;
    //     SWPool[TRANING_CAMP][EPIC][2] = 2;
    //     SWPool[TRANING_CAMP][EPIC][3] = 3;
    //     SWPool[TRANING_CAMP][EPIC][4] = 4;

    //     // --- For Epic Box ------
    //     BPPool[EPIC][RARE][GEAR][0] = 8;
    //     BPPool[EPIC][RARE][GEAR][1] = 9;
    //     BPPool[EPIC][RARE][GEAR][2] = 10;

    //     BPPool[EPIC][RARE][DRO][0] = 8;
    //     BPPool[EPIC][RARE][DRO][1] = 9;
    //     BPPool[EPIC][RARE][DRO][2] = 10;

    //     BPPool[EPIC][RARE][SUITE][0] = 6;
    //     BPPool[EPIC][RARE][SUITE][1] = 7;
    //     BPPool[EPIC][RARE][SUITE][2] = 8;
    //     BPPool[EPIC][RARE][SUITE][3] = 9;

    //     BPPool[EPIC][RARE][BOT][0] = 8;
    //     BPPool[EPIC][RARE][BOT][1] = 9;
    //     BPPool[EPIC][RARE][BOT][2] = 10;

    //     BPPool[EPIC][RARE][WEAP][0] = 9;
    //     BPPool[EPIC][RARE][WEAP][1] = 10;
    //     BPPool[EPIC][RARE][WEAP][2] = 11;
    //     BPPool[EPIC][RARE][WEAP][3] = 12;
    //     BPPool[EPIC][RARE][WEAP][4] = 13;
    //     BPPool[EPIC][RARE][WEAP][5] = 14;

    //     //Epic
    //     BPPool[EPIC][EPIC][GEAR][0] = 8;
    //     BPPool[EPIC][EPIC][GEAR][1] = 9;
    //     BPPool[EPIC][EPIC][GEAR][2] = 10;

    //     BPPool[EPIC][EPIC][DRO][0] = 8;
    //     BPPool[EPIC][EPIC][DRO][1] = 9;
    //     BPPool[EPIC][EPIC][DRO][2] = 10;

    //     BPPool[EPIC][EPIC][SUITE][0] = 6;
    //     BPPool[EPIC][EPIC][SUITE][1] = 7;
    //     BPPool[EPIC][EPIC][SUITE][2] = 8;
    //     BPPool[EPIC][EPIC][SUITE][3] = 9;

    //     BPPool[EPIC][EPIC][BOT][0] = 8;
    //     BPPool[EPIC][EPIC][BOT][1] = 9;
    //     BPPool[EPIC][EPIC][BOT][2] = 10;

    //     BPPool[EPIC][EPIC][WEAP][0] = 9;
    //     BPPool[EPIC][EPIC][WEAP][1] = 10;
    //     BPPool[EPIC][EPIC][WEAP][2] = 11;
    //     BPPool[EPIC][EPIC][WEAP][3] = 12;
    //     BPPool[EPIC][EPIC][WEAP][4] = 13;
    //     BPPool[EPIC][EPIC][WEAP][5] = 14;

    //     // GenPool[EPIC][COMMON][0] = 0;
    //     // GenPool[EPIC][COMMON][1] = 1;
    //     // GenPool[EPIC][COMMON][2] = 2;
    //     // GenPool[EPIC][COMMON][3] = 3;
    //     // GenPool[EPIC][COMMON][4] = 4;
    //     // GenPool[EPIC][COMMON][5] = 5;
    //     // GenPool[EPIC][COMMON][6] = 6;

    //     GenPool[EPIC][RARE][0] = 7;
    //     GenPool[EPIC][RARE][1] = 8;
    //     GenPool[EPIC][RARE][2] = 9;
    //     GenPool[EPIC][RARE][3] = 10;
    //     GenPool[EPIC][RARE][4] = 11;
    //     GenPool[EPIC][RARE][5] = 12;

    //     GenPool[EPIC][EPIC][0] = 13;
    //     GenPool[EPIC][EPIC][1] = 14;
    //     GenPool[EPIC][EPIC][2] = 15;
    //     GenPool[EPIC][EPIC][3] = 16;

    //     //BattleGearCampPool
    //     // SWPool[GEAR][EPIC][0] = 0;
    //     // SWPool[GEAR][EPIC][1] = 0;
    //     // SWPool[GEAR][EPIC][2] = 0;
    //     // SWPool[GEAR][EPIC][3] = 0;
    //     // SWPool[GEAR][EPIC][4] = 0;
    //     // SWPool[GEAR][EPIC][5] = 0;
    //     // SWPool[GEAR][EPIC][6] = 0;
    //     // SWPool[GEAR][EPIC][7] = 0;
    //     // SWPool[GEAR][EPIC][8] = 0;
    //     // SWPool[GEAR][EPIC][9] = 0;
    //     // SWPool[GEAR][EPIC][10] = 0;
    //     // SWPool[GEAR][EPIC][11] = 0;
    //     // SWPool[GEAR][EPIC][12] = 0;
    //     // SWPool[GEAR][EPIC][13] = 0;
    //     // SWPool[GEAR][EPIC][14] = 0;
    //     // SWPool[GEAR][EPIC][15] = 0;
    //     SWPool[GEAR][EPIC][16] = 1;
    //     SWPool[GEAR][EPIC][17] = 1;
    //     SWPool[GEAR][EPIC][18] = 2;
    //     SWPool[GEAR][EPIC][19] = 2;
    //     SWPool[GEAR][EPIC][20] = 3;
    //     SWPool[GEAR][EPIC][21] = 3;
    //     SWPool[GEAR][EPIC][22] = 4;
    //     SWPool[GEAR][EPIC][23] = 4;
    //     SWPool[GEAR][EPIC][24] = 5;
    //     SWPool[GEAR][EPIC][25] = 6;
    //     SWPool[GEAR][EPIC][26] = 7;
    //     SWPool[GEAR][EPIC][27] = 8;
    //     SWPool[GEAR][EPIC][28] = 9;
    //     SWPool[GEAR][EPIC][29] = 10;

    //     //DRO
    //     // SWPool[DRO][EPIC][0] = 0;
    //     // SWPool[DRO][EPIC][1] = 0;
    //     // SWPool[DRO][EPIC][2] = 0;
    //     // SWPool[DRO][EPIC][3] = 0;
    //     // SWPool[DRO][EPIC][4] = 0;
    //     // SWPool[DRO][EPIC][5] = 0;
    //     // SWPool[DRO][EPIC][6] = 0;
    //     // SWPool[DRO][EPIC][7] = 0;
    //     // SWPool[DRO][EPIC][8] = 0;
    //     // SWPool[DRO][EPIC][9] = 0;
    //     // SWPool[DRO][EPIC][10] = 0;
    //     // SWPool[DRO][EPIC][11] = 0;
    //     // SWPool[DRO][EPIC][12] = 0;
    //     // SWPool[DRO][EPIC][13] = 0;
    //     // SWPool[DRO][EPIC][14] = 0;
    //     // SWPool[DRO][EPIC][15] = 0;
    //     SWPool[DRO][EPIC][16] = 1;
    //     SWPool[DRO][EPIC][17] = 1;
    //     SWPool[DRO][EPIC][18] = 2;
    //     SWPool[DRO][EPIC][19] = 2;
    //     SWPool[DRO][EPIC][20] = 3;
    //     SWPool[DRO][EPIC][21] = 3;
    //     SWPool[DRO][EPIC][22] = 4;
    //     SWPool[DRO][EPIC][23] = 4;
    //     SWPool[DRO][EPIC][24] = 5;
    //     SWPool[DRO][EPIC][25] = 6;
    //     SWPool[DRO][EPIC][26] = 7;
    //     SWPool[DRO][EPIC][27] = 8;
    //     SWPool[DRO][EPIC][28] = 9;
    //     SWPool[DRO][EPIC][29] = 10;

    //     //SUITE
    //     // SWPool[SUITE][EPIC][0] = 0;
    //     // SWPool[SUITE][EPIC][1] = 0;
    //     // SWPool[SUITE][EPIC][2] = 0;
    //     // SWPool[SUITE][EPIC][3] = 0;
    //     SWPool[SUITE][EPIC][4] = 1;
    //     SWPool[SUITE][EPIC][5] = 1;
    //     SWPool[SUITE][EPIC][6] = 1;
    //     SWPool[SUITE][EPIC][7] = 1;
    //     SWPool[SUITE][EPIC][8] = 2;
    //     SWPool[SUITE][EPIC][9] = 2;
    //     SWPool[SUITE][EPIC][10] = 2;
    //     SWPool[SUITE][EPIC][11] = 2;
    //     SWPool[SUITE][EPIC][12] = 3;
    //     SWPool[SUITE][EPIC][13] = 4;
    //     SWPool[SUITE][EPIC][14] = 5;
    //     SWPool[SUITE][EPIC][15] = 6;
    //     SWPool[SUITE][EPIC][16] = 7;
    //     SWPool[SUITE][EPIC][17] = 8;
    //     SWPool[SUITE][EPIC][18] = 9;

    //     //BOT
    //     // SWPool[BOT][EPIC][0] = 0;
    //     // SWPool[BOT][EPIC][1] = 0;
    //     // SWPool[BOT][EPIC][2] = 0;
    //     // SWPool[BOT][EPIC][3] = 0;
    //     // SWPool[BOT][EPIC][4] = 0;
    //     // SWPool[BOT][EPIC][5] = 0;
    //     // SWPool[BOT][EPIC][6] = 0;
    //     // SWPool[BOT][EPIC][7] = 0;
    //     // SWPool[BOT][EPIC][8] = 0;
    //     // SWPool[BOT][EPIC][9] = 0;
    //     // SWPool[BOT][EPIC][10] = 0;
    //     // SWPool[BOT][EPIC][11] = 0;
    //     // SWPool[BOT][EPIC][12] = 0;
    //     // SWPool[BOT][EPIC][13] = 0;
    //     // SWPool[BOT][EPIC][14] = 0;
    //     // SWPool[BOT][EPIC][15] = 0;
    //     // SWPool[BOT][EPIC][16] = 0;
    //     // SWPool[BOT][EPIC][17] = 0;
    //     SWPool[BOT][EPIC][18] = 1;
    //     SWPool[BOT][EPIC][19] = 1;
    //     SWPool[BOT][EPIC][20] = 2;
    //     SWPool[BOT][EPIC][21] = 2;
    //     SWPool[BOT][EPIC][22] = 4;
    //     SWPool[BOT][EPIC][23] = 4;
    //     SWPool[BOT][EPIC][24] = 5;
    //     SWPool[BOT][EPIC][25] = 6;
    //     SWPool[BOT][EPIC][26] = 7;
    //     SWPool[BOT][EPIC][27] = 8;
    //     SWPool[BOT][EPIC][28] = 9;
    //     SWPool[BOT][EPIC][29] = 10;

    //     //GEN
    //     // SWPool[GEN][EPIC][0] = 0;
    //     // SWPool[GEN][EPIC][1] = 0;
    //     // SWPool[GEN][EPIC][2] = 0;
    //     SWPool[GEN][EPIC][3] = 1;
    //     SWPool[GEN][EPIC][4] = 1;
    //     SWPool[GEN][EPIC][5] = 1;
    //     SWPool[GEN][EPIC][6] = 2;
    //     SWPool[GEN][EPIC][7] = 2;
    //     SWPool[GEN][EPIC][8] = 2;
    //     SWPool[GEN][EPIC][9] = 3;
    //     SWPool[GEN][EPIC][10] = 3;
    //     SWPool[GEN][EPIC][11] = 3;
    //     SWPool[GEN][EPIC][12] = 4;
    //     SWPool[GEN][EPIC][13] = 4;
    //     SWPool[GEN][EPIC][14] = 4;
    //     SWPool[GEN][EPIC][15] = 5;
    //     SWPool[GEN][EPIC][16] = 5;
    //     SWPool[GEN][EPIC][17] = 6;
    //     SWPool[GEN][EPIC][18] = 6;
    //     SWPool[GEN][EPIC][19] = 7;
    //     SWPool[GEN][EPIC][20] = 8;
    //     SWPool[GEN][EPIC][21] = 9;
    //     SWPool[GEN][EPIC][22] = 10;
    //     SWPool[GEN][EPIC][23] = 11;
    //     SWPool[GEN][EPIC][24] = 12;
    //     SWPool[GEN][EPIC][25] = 13;
    //     SWPool[GEN][EPIC][26] = 14;
    //     SWPool[GEN][EPIC][27] = 15;
    //     SWPool[GEN][EPIC][28] = 16;

    //     //WEAP
    //     // SWPool[WEAP][RARE][0] = 0;
    //     // SWPool[WEAP][RARE][1] = 0;
    //     // SWPool[WEAP][RARE][2] = 0;
    //     // SWPool[WEAP][RARE][3] = 0;
    //     SWPool[WEAP][RARE][4] = 1;
    //     SWPool[WEAP][RARE][5] = 1;
    //     SWPool[WEAP][RARE][6] = 1;
    //     SWPool[WEAP][RARE][7] = 1;
    //     SWPool[WEAP][RARE][8] = 2;
    //     SWPool[WEAP][RARE][9] = 2;
    //     SWPool[WEAP][RARE][10] = 2;
    //     SWPool[WEAP][RARE][11] = 2;
    //     SWPool[WEAP][RARE][12] = 3;
    //     SWPool[WEAP][RARE][13] = 3;
    //     SWPool[WEAP][RARE][14] = 3;
    //     SWPool[WEAP][RARE][15] = 3;
    //     SWPool[WEAP][RARE][16] = 4;
    //     SWPool[WEAP][RARE][17] = 4;
    //     SWPool[WEAP][RARE][18] = 5;
    //     SWPool[WEAP][RARE][19] = 5;
    //     SWPool[WEAP][RARE][20] = 6;
    //     SWPool[WEAP][RARE][21] = 6;
    //     SWPool[WEAP][RARE][22] = 7;
    //     SWPool[WEAP][RARE][23] = 7;
    //     SWPool[WEAP][RARE][24] = 8;
    //     SWPool[WEAP][RARE][25] = 8;
    //     SWPool[WEAP][RARE][26] = 9;
    //     SWPool[WEAP][RARE][27] = 10;
    //     SWPool[WEAP][RARE][28] = 11;
    //     SWPool[WEAP][RARE][29] = 12;
    //     SWPool[WEAP][RARE][30] = 13;
    //     SWPool[WEAP][RARE][31] = 14;
    // }

    mapping(uint256 => uint256[]) rateResults;
    mapping(uint256 => uint256[]) percentage;

    mapping (uint256 => mapping(uint256=> uint256[])) GenPoolPercentage;
    mapping (uint256 => mapping(uint256=> uint256[])) GenPoolResults;

    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256[]))) BPPoolPercentage;
    mapping(uint256 => mapping(uint256 => mapping(uint256 => uint256[]))) BPPoolResults;

    mapping (uint256 => mapping(uint256 => uint256[])) SWPoolResults;
    mapping (uint256 => mapping(uint256 => uint256[])) SWPoolPercentage;

    function initial() public onlyOwner {

        EPool[0] = GEAR; //Battle Gear
        EPool[1] = DRO; //Battle DRO
        EPool[2] = SUITE; //Battle Suit
        EPool[3] = BOT; //Battle Bot
        EPool[4] = WEAP; //WEAP

        //COMMON RATE
        rateResults[COMMON_BOX] = [
            BLUEPRINT_COMM,
            BLUEPRINT_RARE,
            GENOMIC_COMMON,
            SPACE_WARRIOR
        ];
        percentage[COMMON_BOX] = [
            uint256(3000),
            uint256(2000),
            uint256(4000),
            uint256(1000)
        ];

        GenPoolPercentage[COMMON_BOX][COMMON] = [0,1,2,3,4,5,6];
        GenPoolPercentage[COMMON_BOX][COMMON] = [
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400)
        ];

        //COMMON
        BPPoolPercentage[COMMON_BOX][COMMON][GEAR] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[COMMON_BOX][COMMON][GEAR] = [1,2,3,4];

        BPPoolPercentage[COMMON_BOX][COMMON][DRO] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[COMMON_BOX][COMMON][DRO] = [1,2,3,4];

        BPPoolPercentage[COMMON_BOX][COMMON][SUITE] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[COMMON_BOX][COMMON][SUITE] = [0,1,2];

        BPPoolPercentage[COMMON_BOX][COMMON][BOT] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[COMMON_BOX][COMMON][BOT] = [1,2,3,4];

        BPPoolPercentage[COMMON_BOX][COMMON][WEAP] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[COMMON_BOX][COMMON][WEAP] = [0,1,2,3];


        //RARE
        BPPoolPercentage[COMMON_BOX][RARE][GEAR] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[COMMON_BOX][RARE][GEAR] = [5,6,7];

        BPPoolPercentage[COMMON_BOX][RARE][DRO] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[COMMON_BOX][RARE][DRO] = [5,6,7];

        BPPoolPercentage[COMMON_BOX][RARE][SUITE] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[COMMON_BOX][RARE][SUITE] = [3,4,5];

        BPPoolPercentage[COMMON_BOX][RARE][BOT] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[COMMON_BOX][RARE][BOT] = [5,6,7];

        BPPoolPercentage[COMMON_BOX][RARE][WEAP] = [uint256(2000),uint256(2000),uint256(2000),uint256(2000),uint256(2000)];
        BPPoolResults[COMMON_BOX][RARE][WEAP] = [4,5,6,7,8];


        // SWPoolResults[TRANING_CAMP][COMMON] = [];
        // SWPoolPercentage[TRANING_CAMP][COMMON] = [];
      

        //RARE RATE
        rateResults[RARE_BOX] = [
            BLUEPRINT_COMM,
            BLUEPRINT_RARE,
            BLUEPRINT_EPIC,
            GENOMIC_COMMON,
            GENOMIC_RARE,
            SPACE_WARRIOR
        ];
        percentage[RARE_BOX] = [
            uint256(1000),
            uint256(1000),
            uint256(500),
            uint256(2000),
            uint256(3000),
            uint256(2500)
        ];

        GenPoolPercentage[RARE_BOX][COMMON] = [0,1,2,3,4,5,6];
        GenPoolPercentage[RARE_BOX][COMMON] = [
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400),
            uint256(1400)
        ];

        GenPoolPercentage[RARE_BOX][RARE] = [7,8,9,10,11,12];
        GenPoolPercentage[RARE_BOX][RARE] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600) 
        ];

        //COMMON
        BPPoolPercentage[RARE_BOX][COMMON][GEAR] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[RARE_BOX][COMMON][GEAR] = [1,2,3,4];

        BPPoolPercentage[RARE_BOX][COMMON][DRO] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[RARE_BOX][COMMON][DRO] = [1,2,3,4];

        BPPoolPercentage[RARE_BOX][COMMON][SUITE] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][COMMON][SUITE] = [0,1,2];

        BPPoolPercentage[RARE_BOX][COMMON][BOT] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[RARE_BOX][COMMON][BOT] = [1,2,3,4];

        BPPoolPercentage[RARE_BOX][COMMON][WEAP] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[RARE_BOX][COMMON][WEAP] = [0,1,2,3];


        //RARE
        BPPoolPercentage[RARE_BOX][RARE][GEAR] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][RARE][GEAR] = [5,6,7];

        BPPoolPercentage[RARE_BOX][RARE][DRO] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][RARE][DRO] = [5,6,7];

        BPPoolPercentage[RARE_BOX][RARE][SUITE] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][RARE][SUITE] = [3,4,5];

        BPPoolPercentage[RARE_BOX][RARE][BOT] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][RARE][BOT] = [5,6,7];

        BPPoolPercentage[RARE_BOX][RARE][WEAP] = [uint256(2000),uint256(2000),uint256(2000),uint256(2000),uint256(2000)];
        BPPoolResults[RARE_BOX][RARE][WEAP] = [4,5,6,7,8];

        //EPIC
        BPPoolPercentage[RARE_BOX][EPIC][GEAR] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][EPIC][GEAR] = [8,9,10];

        BPPoolPercentage[RARE_BOX][EPIC][DRO] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][EPIC][DRO] = [8,9,10];

        BPPoolPercentage[RARE_BOX][EPIC][SUITE] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[RARE_BOX][EPIC][SUITE] = [6,7,8,9];

        BPPoolPercentage[RARE_BOX][EPIC][BOT] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[RARE_BOX][EPIC][BOT] = [8,9,10];

        BPPoolPercentage[RARE_BOX][EPIC][WEAP] = [uint256(1600),uint256(1600),uint256(1600),uint256(1600),uint256(1600)];
        BPPoolResults[RARE_BOX][EPIC][WEAP] = [9,10,11,12,13,14];

        //EPIC RATE
        rateResults[EPIC_BOX] = [
            BLUEPRINT_EPIC,
            GENOMIC_RARE,
            GENOMIC_EPIC,
            SPACE_WARRIOR
        ];
        percentage[EPIC_BOX] = [
            uint256(1000),
            uint256(1000),
            uint256(1000),
            uint256(7000)
        ];
 
        GenPoolPercentage[EPIC_BOX][RARE] = [7,8,9,10,11,12];
        GenPoolPercentage[EPIC_BOX][RARE] = [
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600),
            uint256(1600) 
        ];

        GenPoolPercentage[EPIC_BOX][RARE] = [13,14,15,16];
        GenPoolPercentage[EPIC_BOX][RARE] = [
            uint256(2500),
            uint256(2500),
            uint256(2500),
            uint256(2500)
        ];

        //EPIC
        BPPoolPercentage[EPIC_BOX][EPIC][GEAR] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[EPIC_BOX][EPIC][GEAR] = [8,9,10];

        BPPoolPercentage[EPIC_BOX][EPIC][DRO] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[EPIC_BOX][EPIC][DRO] = [8,9,10];

        BPPoolPercentage[EPIC_BOX][EPIC][SUITE] = [uint256(2500),uint256(2500),uint256(2500),uint256(2500)];
        BPPoolResults[EPIC_BOX][EPIC][SUITE] = [6,7,8,9];

        BPPoolPercentage[EPIC_BOX][EPIC][BOT] = [uint256(3300),uint256(3300),uint256(3300)];
        BPPoolResults[EPIC_BOX][EPIC][BOT] = [8,9,10];

        BPPoolPercentage[EPIC_BOX][EPIC][WEAP] = [uint256(1600),uint256(1600),uint256(1600),uint256(1600),uint256(1600)];
        BPPoolResults[EPIC_BOX][EPIC][WEAP] = [9,10,11,12,13,14];
        

        //SPECIAL RATE
        rateResults[SPECIAL_BOX] = [SPACE_WARRIOR];
        percentage[SPECIAL_BOX] = [uint256(10000)];
    }

    function getGenPool(
        uint256 _nftType,
        uint256 _rarity,
        uint256 _number
    ) public view returns (uint256) {

        uint256  _modNumber = _number % GenPoolPercentage[_nftType][_rarity].length;
        uint256 amount = 1000;
        uint256 number = 0;

        for (uint256 p = 0; p < GenPoolPercentage[_nftType][_rarity].length; p++) {
            uint256 qtyItem = (amount * GenPoolPercentage[_nftType][_rarity][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == number) {
                    return GenPoolResults[_nftType][_rarity][p];
                }

                number++;
            }
        }

        return 0;
    }

    function getNFTPool(uint256 _nftType, uint256 _number)
        public
        view
        returns (uint256)
    {
        uint256  _modNumber = _number % percentage[_nftType].length;
        uint256 amount = 1000;
        uint256 number = 0;

        for (uint256 p = 0; p < percentage[_nftType].length; p++) {
            uint256 qtyItem = (amount * percentage[_nftType][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == number) {
                    return rateResults[_nftType][p];
                }

                number++;
            }
        }

        return 0;
    }

    function getEquipmentPool(uint256 _number) public view returns (uint256) {
        return EPool[_number];
    }

    function getBlueprintPool(
        uint256 _nftType,
        uint256 _rarity,
        uint256 eTypeId,
        uint256 _number
    ) public view returns (uint256) {
        uint256 amount = 1000;
        uint256 number = 0;

        uint256  _modNumber = _number % BPPoolPercentage[_nftType][_rarity][eTypeId].length;

        for (
            uint256 p = 0;
            p < BPPoolPercentage[_nftType][_rarity][eTypeId].length;
            p++
        ) {
            uint256 qtyItem = (amount *
                BPPoolPercentage[_nftType][_rarity][eTypeId][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == number) {
                    return BPPoolResults[_nftType][_rarity][eTypeId][p];
                }

                number++;
            }
        }

        //  BPPool[COMMON][COMMON][GEAR][0] = 1;
        return 0;
    }



    function getSpaceWarriorPool(
        uint256 _part,
        uint256 _nftType,
        uint256 _number
    ) public view returns (uint256) {

        uint256  _modNumber = _number % SWPoolPercentage[_part][_nftType].length;
        uint256 amount = 1000;
        uint256 number = 0;

        for (uint256 p = 0; p < SWPoolPercentage[_part][_nftType].length; p++) {
            uint256 qtyItem = (amount * SWPoolPercentage[_part][_nftType][p]) / 10000;
            for (uint256 i = 0; i < qtyItem; i++) {
                if (_modNumber == number) {
                    return SWPoolResults[_part][_nftType][p];
                }

                number++;
            }
        }

        return 0;
    }
}
