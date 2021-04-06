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
using UnityEngine.XR.Interaction.Toolkit;

public class NetworkPlayer : MonoBehaviour
{
    #region Variables
    public Transform head;          //Reference to the player Head
    public Transform leftHand;      //Reference to the player Left Hand
    public Transform rightHand;     //Reference to the player Right Hand

    public Animator leftHandAnimator;
    public Animator rightHandAnimator;


    private Transform headRig;
    private Transform leftHandRig;
    private Transform rightHandRig;

    private PhotonView photonView;
    #endregion

    #region Unity Methods

    void Start()
    {
        photonView = GetComponent<PhotonView>();

        //Locates the XRRig in the scene
        XRRig rig = FindObjectOfType<XRRig>();
        //Stores the transform of the Camera 
        headRig = rig.transform.Find("Camera Offset/Main Camera");
        //Store the transform of the Left Hand 
        leftHandRig = rig.transform.Find("Camera Offset/LeftHand Controller");
        //Store the transform of the Left Hand 
        rightHandRig = rig.transform.Find("Camera Offset/RightHand Controller");

        if(photonView.IsMine)
        {
            foreach (var item in GetComponentsInChildren<Renderer>()) //Returns all the renderer components of the network player
            {
                //Disables the renderer
                item.enabled = false;
            }
        }

    }

   
    void Update()
    {
        //Checks to see which prefab component is being used 
        //If it's the users prefab then Update the following
        if(photonView.IsMine)
        {

            //Updates the Position/Rotation of the Head
            MapPosition(head, headRig);
            //Updates the Position/Rotation of the Left Hand
            MapPosition(leftHand, leftHandRig);
            //Updates the Position/Rotation of the Right Hand
            MapPosition(rightHand, rightHandRig);


            //Updates the animation of the Left Hand
            UpdateHandAnimation(InputDevices.GetDeviceAtXRNode(XRNode.LeftHand), leftHandAnimator);
            //Updates the animation of the Right Hand
            UpdateHandAnimation(InputDevices.GetDeviceAtXRNode(XRNode.RightHand), rightHandAnimator);

        }


    }

    void UpdateHandAnimation(InputDevice targetDevice, Animator handAnimator)  //Updates the hand animation
    {
        if (targetDevice.TryGetFeatureValue(CommonUsages.trigger, out float triggerValue))
        {
            handAnimator.SetFloat("Trigger", triggerValue);
        }
        else
        {
            handAnimator.SetFloat("Trigger", 0);
        }

        if (targetDevice.TryGetFeatureValue(CommonUsages.grip, out float gripValue))
        {
            handAnimator.SetFloat("Grip", gripValue);
        }
        else
        {
            handAnimator.SetFloat("Grip", 0);
        }
    }

    void MapPosition(Transform target, Transform rigTransform) //Syncs the position of the XR device with the ingame player
    {
       

        //Sets the position to the target
        target.position = rigTransform.position;
        //Sets the rotation to the target
        target.rotation = rigTransform.rotation;
    }

    #endregion
}
