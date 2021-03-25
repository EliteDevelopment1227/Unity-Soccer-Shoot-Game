using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
public class GoalKeeper : MonoBehaviour
{
    // Start is called before the first frame update
    private Player Player;
    NavMeshAgent enemy;
    public List<Rigidbody> enemyrigidbodies = new List<Rigidbody>();




    bool move;
    void Start()
    {
        Player = FindObjectOfType<Player>();
        move = false;
        enemy = GetComponent<NavMeshAgent>();
    }

    // Update is called once per frame
    int i = 0;
    void Update()
    {
         if (Vector3.Distance(this.transform.position, Player.transform.position) <10 && i==0)
        {
           // this.gameObject.GetComponent<Animator>().SetBool("goalkeeper", true);
            this.gameObject.GetComponent<Animator>().SetBool("goalkeeper", true);
            this.transform.position = Vector3.MoveTowards(this.transform.position, Player.transform.position, 18 * Time.deltaTime);
            Invoke("stopfollow", 0.5f);
        }
    }
    public void RagdollOn()
    {
        enemy.isStopped = true;
        this.GetComponent<Animator>().enabled = false;
        for (int i = 0; i < enemyrigidbodies.Count; i++)
        {
            enemyrigidbodies[i].isKinematic = false;
        }
         Destroy(this.gameObject, 3f);
    }

    void stopfollow()
    {
        i = 1;
    }
}
