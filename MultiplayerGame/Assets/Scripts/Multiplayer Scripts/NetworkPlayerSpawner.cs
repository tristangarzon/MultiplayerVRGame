/*
* Made by: Tristan Garzon
* 
* Script Summary:
* 
* Handles the spawning of other player
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Photon.Pun;

public class NetworkPlayerSpawner : MonoBehaviourPunCallbacks
{
    #region Variables
    private GameObject spawnedPlayerPrefab;
    #endregion

    #region Unity Methods

    public override void OnJoinedRoom() //Called when a player joins a room
    {
        base.OnJoinedRoom();

        //Spawns a player into the world. Player must have the same name as the one linked below
        spawnedPlayerPrefab = PhotonNetwork.Instantiate("Network Player", transform.position, transform.rotation);
    }

    public override void OnLeftRoom() //Called when a player leaves the room
    {
        base.OnLeftRoom();

        //Destorys the spawnedPlayerPrefab after they have left the room
        PhotonNetwork.Destroy(spawnedPlayerPrefab);
    }

    #endregion
}
