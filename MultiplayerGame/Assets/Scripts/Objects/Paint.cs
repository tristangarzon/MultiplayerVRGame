/*
* Made by: Tristan Garzon
* 
* Script Summary:
*
*/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;

public class Paint : MonoBehaviour
{
    #region Variables
    public InputHelpers.Button drawInput;
    public Transform drawPositionSource;
    public float lineWidth = 0.03f;
    public Material lineMaterial;
    public float distanceThreshold = 0.05f;


    private bool isDrawing = false;
    private List<Vector3> currentLinePositions = new List<Vector3>();
    private LineRenderer currentLine;
    private XRController controller;
    #endregion
	
    #region Unity Methods

    void Start()
    {
        controller = GetComponent<XRController>();
    }

   
    void Update()
    {

        if(isDrawing)
        {
            UpdateDrawing();
        }
        if(!isDrawing)
        {
            StopDrawing();
        }
       
    }

    public void SetLineMaterial(Material newMaterial) //Changes Line Material to a new Material
    {
        lineMaterial = newMaterial;
    }


    public void StartDrawing()
    {
        isDrawing = true;
        //Create Line
        GameObject lineGameObject = new GameObject("Line");
        currentLine = lineGameObject.AddComponent<LineRenderer>();

        UpdateLine();
    }

    void UpdateLine() //Updates the Line
    {
        //Update the Line Position
        currentLinePositions.Add(drawPositionSource.position);
        currentLine.positionCount = currentLinePositions.Count;
        currentLine.SetPositions(currentLinePositions.ToArray());

        //Update Line Visual
        currentLine.material = lineMaterial;
        currentLine.startWidth = lineWidth;
    }

    public void StopDrawing()
    {
        isDrawing = false;
        currentLinePositions.Clear();
        currentLine = null;
    }

    public void UpdateDrawing()
    {
        //Checks to see if we have a line
        if (!currentLine || currentLinePositions.Count == 0)
            return;

        Vector3 lastSetPosition = currentLinePositions[currentLinePositions.Count - 1];
        if(Vector3.Distance(lastSetPosition, drawPositionSource.position) > distanceThreshold)
        {
            UpdateLine();
        }
    }

    #endregion
}
