using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
public class InGameUi : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject levelCompletepanel, levelfailpanel, menu;
    public Text scoreText;
    public int Score=5;
    public GameObject GoalParticle;
    void Start()
    {
        
    }

    public void onNextButtonPress()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }
    Enemy[] enemies;
    public void PlaybuttonPress()
    {
        if (FindObjectOfType<Enemy>())
        {
            enemies = FindObjectsOfType<Enemy>();
            for(int i = 0; i < enemies.Length; i++)
            {
                enemies[i].startmove = true;
            }
        }
        menu.SetActive(false);  
    }
    public void onretrybuttonpress()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }
    public void levelcomplete()
    {
        if(!levelCompletepanel.activeInHierarchy && !levelfailpanel.activeInHierarchy)
        {
            scoreText.text = "SCORE " + Score;
            levelCompletepanel.SetActive(true);
            GoalParticle.SetActive(true);
        }
    }
    public void levelfail()
    {
        if (!levelCompletepanel.activeInHierarchy && !levelfailpanel.activeInHierarchy)
        {
            levelfailpanel.SetActive(true);
        }
    }
}
