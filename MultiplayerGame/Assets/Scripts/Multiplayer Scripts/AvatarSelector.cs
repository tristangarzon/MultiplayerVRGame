/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarSelector : MonoBehaviour
{
    #region Variables

    #endregion
	
    #region Unity Methods

    public void SetAvatarID(int index) //Sets the Avatar ID that the player selects
    {
        PlayerPrefs.SetInt("AvatarID", index);
    }

    #endregion
}
