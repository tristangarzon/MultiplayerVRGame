/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeColorPaint : MonoBehaviour
{
    #region Variables
    public Material newMaterial;
    #endregion

    #region Unity Methods

    private void OnTriggerEnter(Collider other)
    {

        //Change Line Material
        other.SendMessageUpwards("SetLineMaterial", newMaterial, SendMessageOptions.DontRequireReceiver);
    }

    #endregion
}
