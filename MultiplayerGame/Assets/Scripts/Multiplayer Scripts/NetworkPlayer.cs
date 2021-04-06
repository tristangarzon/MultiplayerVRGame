/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;
using Photon.Pun;

public class NetworkPlayer : MonoBehaviour
{
    #region Variables
    public Transform head;          //Reference to the player Head
    public Transform leftHand;      //Reference to the player Left Hand
    public Transform rightHand;     //Reference to the player Right Hand

    private PhotonView photonView;
    #endregion

    #region Unity Methods

    void Start()
    {
        photonView = GetComponent<PhotonView>();
    }

   
    void Update()
    {
        //Checks to see which prefab component is being used 
        //If it's the users prefab then Update the following
        if(photonView.IsMine)
        {
           
            rightHand.gameObject.SetActive(false);
            leftHand.gameObject.SetActive(false);
            head.gameObject.SetActive(false);

            //Updates the Position/Rotation of the Head
            MapPosition(head, XRNode.Head);
            //Updates the Position/Rotation of the Left Hand
            MapPosition(leftHand, XRNode.LeftHand);
            //Updates the Position/Rotation of the Right Hand
            MapPosition(rightHand, XRNode.RightHand);
        }

      
    }

    void MapPosition(Transform target, XRNode node) //Syncs the position of the XR device with the ingame player
    {
        //Gets the position of the XR device
        InputDevices.GetDeviceAtXRNode(node).TryGetFeatureValue(CommonUsages.devicePosition, out Vector3 position);
        //Gets the rotation of the XR device
        InputDevices.GetDeviceAtXRNode(node).TryGetFeatureValue(CommonUsages.deviceRotation, out Quaternion rotation);

        //Sets the position to the target
        target.position = position;
        //Sets the rotation to the target
        target.rotation = rotation;
    }

    #endregion
}
