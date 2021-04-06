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

[System.Serializable]
public class DefaultRoom
{
    public string Name;             //Sets the name of the room
    public int sceneIndex;          //Sets the scene of the room
    public int maxPlayer;           //Sets the max player per room amount
    public bool isRoomVisible;      //Toggle for if the room is visible to other players
    public bool isRoomOpen;      //Toggle for if the room is open to other players
}


public class NetworkManager : MonoBehaviourPunCallbacks
{
    #region Variables
    public List<DefaultRoom> defaultRooms;  //Makes a reference for the DefaultRoom variables

    //UI
    public GameObject roomUI;               //Stores the room UI buttons
        

    #endregion

    #region Unity Methods

    public void ConnectToServer()  //Connects the user to the server
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

        //Player joins the lobby
        PhotonNetwork.JoinLobby(); 
    }

    public override void OnJoinedLobby()
    {
        base.OnJoinedLobby();

        //Server Log
        Debug.Log("***Now connected to the lobby***");

        //Once a player joins the lobby, will show the room UI buttons
        roomUI.SetActive(true);
    }

    public void InitiliazeRoom(int defaultRoomIndex) //Will create or attemp to join a new room
    {

        DefaultRoom roomSettings = defaultRooms[defaultRoomIndex];

        //Loads the scene 
        PhotonNetwork.LoadLevel(roomSettings.sceneIndex);

        //Creates new room
        RoomOptions roomOptions = new RoomOptions();

        //Sets Maxplayers per room
        roomOptions.MaxPlayers = (byte)roomSettings.maxPlayer;

        //Option for if the room is visible to other players
        roomOptions.IsVisible = roomSettings.isRoomVisible;

        //Option for if the room is open to other players
        roomOptions.IsOpen = roomSettings.isRoomOpen;

        //Conditions for new room
        PhotonNetwork.JoinOrCreateRoom(roomSettings.Name, roomOptions, TypedLobby.Default);
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
