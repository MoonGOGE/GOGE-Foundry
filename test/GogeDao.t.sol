// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "../lib/forge-std/src/Test.sol";
import "./Utility.sol";
import { GogeDAO } from "../src/GogeDao.sol";
import { DogeGaySon } from "../src/GogeToken.sol";

contract DaoTest is Utility, Test {
    GogeDAO gogeDao;
    DogeGaySon gogeToken;

    //Polltype pollType;

    function setUp() public {
        createActors();
        setUpTokens();

        gogeToken = new DogeGaySon(
            address(0x4959bCED128E6F056A6ef959D80Bd1fCB7ba7A4B), //0x4959bCED128E6F056A6ef959D80Bd1fCB7ba7A4B
            address(0xe142E9FCbd9E29C4A65C4979348d76147190a05a),
            100_000_000_000,
            address(0xa30D02C5CdB6a76e47EA0D65f369FD39618541Fe) // goge v1
        );
        
        gogeDao = new GogeDAO(
            address(gogeToken)
        );

        //pollType = gogeDao.PollType();
    }

    function test_gogeDao_init_state() public {
        assertEq(address(gogeToken), gogeDao.governanceTokenAddr());
        assertEq(gogeDao.pollNum(), 0);
    }

    function test_gogeDao_createPoll() public {

        // create poll metadata
        Metadata memory metadata;
        metadata.time1 = block.timestamp + 1 seconds;
        metadata.time2 = block.timestamp + 1 days;
        metadata.addr1 = address(joe);
        metadata.boolVar = true;

        PollType pollType = PollType.modifyBlacklist;

        gogeDao.createPoll(pollType, metadata);

        assertEq(gogeDao.pollNum(), 1);

        //assertEq(gogeDao.pollTypes(1), modifyBlacklist);
        //assertEq(gogeDao.pollMap(1), metadata);
    }
}
