/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour
{
    #region Variables
    [SerializeField]
    private float rotationSpeed = 15f;
    #endregion
	
    #region Unity Methods
   
    private void Update()
    {
        transform.Rotate(Vector3.up * Time.deltaTime * rotationSpeed);
    }

    #endregion
}
