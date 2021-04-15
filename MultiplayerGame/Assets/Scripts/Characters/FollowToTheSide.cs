/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowToTheSide : MonoBehaviour
{
    #region Variables
    public Transform target; // Reference to the VR Camera
    public Vector3 offset;
    #endregion

    #region Unity Methods

    void FixedUpdate()
    {
        //Makes the object follow the player
        transform.position = target.position + Vector3.up * offset.y
            + Vector3.ProjectOnPlane(target.right, Vector3.up).normalized * offset.x
            + Vector3.ProjectOnPlane(target.forward, Vector3.up).normalized * offset.z;

        //Makes the object rotate with the player
        transform.eulerAngles = new Vector3(0, target.eulerAngles.y, 0);
    }

    #endregion
}
