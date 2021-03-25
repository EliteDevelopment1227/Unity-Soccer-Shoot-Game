using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
public class Enemy : MonoBehaviour
{
    // Start is called before the first frame update
    private Player Player;
    NavMeshAgent enemy;
    public List<Rigidbody> enemyrigidbodies = new List<Rigidbody>();




    bool move;
    public bool startmove;
    void Start()
    {
        startmove = false;
        Player = FindObjectOfType<Player>();
        move = false;
        enemy = GetComponent<NavMeshAgent>();
    }

    // Update is called once per frame
    void Update()
    {
        if (startmove)
        {
            if (Vector3.Distance(this.transform.position, Player.transform.position) < 4)
            {
                this.gameObject.GetComponent<Animator>().SetBool("Run", false);
                this.gameObject.GetComponent<Animator>().SetBool("soccer", true);
                move = false;
            }
            else if (Vector3.Distance(this.transform.position, Player.transform.position) < 10)
            {
                Debug.Log("etstst");
                move = true;
            }
            if (move == true)
            {
                this.gameObject.GetComponent<Animator>().SetBool("Run", true);
                enemy.SetDestination(Player.transform.position);
            }
        }
        
    }
    public void RagdollOn()
    {
        FindObjectOfType<InGameUi>().Score += 5;
        enemy.isStopped = true;
        this.GetComponent<Animator>().enabled = false;
        for (int i = 0; i < enemyrigidbodies.Count; i++)
        {
            enemyrigidbodies[i].isKinematic = false;
        }
        Destroy(this.gameObject, 3);

    }
}
