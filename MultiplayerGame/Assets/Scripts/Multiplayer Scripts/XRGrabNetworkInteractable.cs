/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*
* When an object has been grabbed the ownership of the object switches from netural to being owned by the player
* who grabs said object. When a new player decides to grab that object, the ownership of the objects now 
* needs to be switched to the new player attempting to grab the object.
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;
using Photon.Pun;

public class XRGrabNetworkInteractable : XRGrabInteractable
{
    #region Variables
    private PhotonView photonView; 
    #endregion
	
    #region Unity Methods

    void Start()
    {
        photonView = GetComponent<PhotonView>();    //Stores a reference to the photonview component
    }

   
    void Update()
    {
        
    }

    protected override void OnSelectEntered(XRBaseInteractor interactor) //Called when an object is being grabbed
    {
        //Request ownership of an object
       
        photonView.RequestOwnership();

        base.OnSelectEntered(interactor);
    }


    #endregion
}
