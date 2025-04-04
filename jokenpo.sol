// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Jokenpo {
    address public juiz;

    struct Partida {
        uint256 id;
        address jogador1;
        address jogador2;
        uint256 resultadoJogador1;
        uint256 resultadoJogador2;
        bool venceJogador1;
        bool venceJogador2;
    }

    mapping(uint256 => Partida) public partidas;

    constructor() {
        juiz = msg.sender; // msg.sender representa quem está executando a transação
    }

    // Apenas o dono do contrato pode executar esta função
    function criarPartida(
        uint256 _id,
        address _jogador1,
        address _jogador2
    ) public {
        require(msg.sender == juiz, "Apenas o juiz pode cadastrar.");

        require(partidas[_id].id == 0, "Partida ja cadastrada.");

        partidas[_id] = Partida({
            id: _id,
            jogador1: _jogador1,
            jogador2: _jogador2,
            resultadoJogador1: 0,
            resultadoJogador2: 0,
            venceJogador1: false,
            venceJogador2: false
        });
    }

    function jogar_jogador1(uint256 _id, uint256 _resultadoJogador1) public {
        require(partidas[_id].id != 0, "Partida nao existe.");

        require(
            partidas[_id].jogador1 == msg.sender,
            "Apenas o jogador1 pode jogar."
        );

        partidas[_id].resultadoJogador1 = _resultadoJogador1;
    }

    function jogar_jogador2(uint256 _id, uint256 _resultadoJogador2) public {
        require(partidas[_id].id != 0, "Partida nao existe.");

        require(
            partidas[_id].jogador2 == msg.sender,
            "Apenas o jogador1 pode jogar."
        );

        partidas[_id].resultadoJogador2 = _resultadoJogador2;
    }

}
