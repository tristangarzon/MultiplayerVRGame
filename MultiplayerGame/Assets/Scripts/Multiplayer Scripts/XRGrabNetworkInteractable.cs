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

    private Vector3 initalAttackLocalPos;
    private Quaternion initialAttachLocalRot;
    #endregion
	
    #region Unity Methods

    void Start()
    {
        photonView = GetComponent<PhotonView>();    //Stores a reference to the photonview component

        //Creates an attach point to an object if it doesn't have one
        if(!attachTransform)
        {
            GameObject grab = new GameObject("Grab Pivot");
            grab.transform.SetParent(transform, false);
            attachTransform = grab.transform;
        }

        initalAttackLocalPos = attachTransform.localPosition;
        initialAttachLocalRot = attachTransform.localRotation;

    }

   
    void Update()
    {
        
    }

    protected override void OnSelectEntered(XRBaseInteractor interactor) //Called when an object is being grabbed
    {
        //Request ownership of an object
       
        photonView.RequestOwnership();

        if(interactor is XRDirectInteractor)
        {
            attachTransform.position = interactor.transform.position;
            attachTransform.rotation = interactor.transform.rotation;
        }
        else
        {
            attachTransform.localPosition = initalAttackLocalPos;
            attachTransform.localRotation = initialAttachLocalRot;
               
        }

        base.OnSelectEntered(interactor);
    }


    #endregion
}
