/*
* Made by: Tristan Garzon
* 
* Script Summary:
* 
* Connects the player to server
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Photon.Pun;
using Photon.Realtime;

public class NetworkManager : MonoBehaviourPunCallbacks
{
    #region Variables
    public byte maxPlayers = 10;    //Sets the max player per room amount
    public bool isRoomVisible = true;   //Toggle for if the room is visible to other players
    public bool isRoomOpen = true;      //Toggle for if the room is open to other players


    #endregion

    #region Unity Methods

    void Start()
    {
        ConnectToServer();
    }

    void ConnectToServer()  //Connects the user to the server
    {
        PhotonNetwork.ConnectUsingSettings();

        //Server Log
        Debug.Log("***Try Connect to Server***");
    }

    public override void OnConnectedToMaster() //When Connected to server, function will get called
    {
        //Server Log
        Debug.Log("***Connected To Server***");

        base.OnConnectedToMaster();

        //Will create or attemp to join a new room\\

        //Creates new room
        RoomOptions roomOptions = new RoomOptions();

        //Sets Maxplayers per room
        roomOptions.MaxPlayers = maxPlayers;

        //Option for if the room is visible to other players
        roomOptions.IsVisible = isRoomVisible;

        //Option for if the room is open to other players
        roomOptions.IsOpen = isRoomOpen;

        //Conditions for new room
        PhotonNetwork.JoinOrCreateRoom("Room 1", roomOptions, TypedLobby.Default);
    }


    public override void OnJoinedRoom() //Called when player joins the room
    {
        //Server Log
        Debug.Log("***Player has joined room***");

        base.OnJoinedRoom();
    }

    public override void OnPlayerEnteredRoom(Player newPlayer)  //Called when a new person joins a room
    {
        //Server Log
        Debug.Log("***New Player Joined the Room***");

        base.OnPlayerEnteredRoom(newPlayer);
    }

    #endregion
}
