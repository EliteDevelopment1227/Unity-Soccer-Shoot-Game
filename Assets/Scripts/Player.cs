using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.EventSystems;
public class Player : MonoBehaviour
{
    // Start is called before the first frame update
    private Rigidbody Rb;
    private float PlayerSpeed=150;





    public Vector3 startpos1, endpos1, direction, mousepositon;
    float touchtimestart, touchtimefinish, timeintervel, timeM;
    public float throughforceinxandy = 1;
    public float throughforceinz = 100;



    //------------swipe variables-----------------
    Vector3 mouseDownPos, mouseUpPos, diffPos;
    public enum Direction { right, left, forward, backward, none }
    public Direction input;
    //------------EndOfSwipeVariables------------

    public bool kick;

    void Start()
    {
        kick = false;
        Rb = this.gameObject.GetComponent<Rigidbody>();
    }


    // Update is called once per frame
    float wait = 10;
    void FixedUpdate()
    {
        if (!EventSystem.current.IsPointerOverGameObject())
        {


#if UNITY_EDITOR
            Swipe2();
#endif
#if UNITY_ANDROID
            TouchSwipe();
#endif

            if (Input.GetKeyDown(KeyCode.Space))
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
            }

            if (Input.GetMouseButtonDown(0))
            {
                touchtimestart = Time.time;
                startpos1 = Input.mousePosition;
                // startpos1 = Camera.main.ScreenToWorldPoint(startpos1);

            }
            if (Input.GetMouseButtonUp(0))
            {
                wait = 10;
                touchtimefinish = Time.time;
                timeintervel = touchtimefinish - touchtimestart;
                endpos1 = Input.mousePosition;
                //endpos1 = Camera.main.ScreenToWorldPoint(endpos1);
                direction = startpos1 - endpos1;
                switch (input)
                {
                    case Direction.forward:
                        Rb.AddForce(-direction.x * throughforceinxandy, -direction.y * throughforceinxandy * 1, throughforceinz / timeintervel * 2f, ForceMode.Impulse);
                        break;
                    case Direction.backward:
                        //  Rb.AddForce(-direction.x * throughforceinxandy, -direction.y * throughforceinxandy * 1, throughforceinz / timeintervel * 2f, ForceMode.Impulse);

                        // Rb.AddForce(-direction.x * throughforceinxandy, -direction.y * throughforceinxandy * 1, -throughforceinz / timeintervel * 2f, ForceMode.Impulse);
                        break;
                    case Direction.left:
                        Rb.AddForce(-direction.x * throughforceinxandy, -direction.y * throughforceinxandy * 1, throughforceinz / timeintervel * 2f, ForceMode.Impulse);

                        // Rb.AddForce(-direction.x*throughforceinxandy, direction.y * throughforceinxandy, throughforceinz / timeintervel * 2f, ForceMode.Impulse);
                        break;
                    case Direction.right:
                        Rb.AddForce(-direction.x * throughforceinxandy, -direction.y * throughforceinxandy * 1, throughforceinz / timeintervel * 2f, ForceMode.Impulse);

                        //Rb.AddForce(-direction.x * throughforceinxandy, -direction.y * throughforceinxandy, throughforceinz / timeintervel * 2f, ForceMode.Impulse);
                        break;
                }
            }
            if (Input.GetMouseButton(0))
            {
                wait -= Time.timeScale;
                if (wait < 0)
                {


                    float rotX = Input.GetAxis("Mouse X");
                    float rotY = Input.GetAxis("Mouse Y");
                    Vector3 pos = new Vector3(rotX, 0, rotY);
                    // input = Direction.none;
                    Rb.AddForce(pos * PlayerSpeed * Time.deltaTime, ForceMode.VelocityChange);
                    //Rb.velocity = pos * PlayerSpeed * Time.deltaTime;
                }

            }
            if (kick)
            {
                Rb.AddForce((Vector3.up * 30 * Time.deltaTime) + Kickdirection.normalized * 10000 * Time.deltaTime, ForceMode.Impulse);
                Invoke("stopkickforce", 4);
            }
        }
    }

  
    Vector2 firstPressPos;
    Vector2 secondPressPos;
    Vector2 currentSwipe;

    public void Swipe2()
    {
        if (Input.GetMouseButtonDown(0))
        {
            //save began touch 2d point
            firstPressPos = new Vector2(Input.mousePosition.x, Input.mousePosition.y);
        }
        if (Input.GetMouseButtonUp(0))
        {
            //save ended touch 2d point
            secondPressPos = new Vector2(Input.mousePosition.x, Input.mousePosition.y);

            //create vector from the two points
            currentSwipe = new Vector2(secondPressPos.x - firstPressPos.x, secondPressPos.y - firstPressPos.y);

            //normalize the 2d vector
            currentSwipe.Normalize();

            //swipe upwards
            if (currentSwipe.y > 0 && currentSwipe.x > -0.3f && currentSwipe.x < 0.3f)
            {
                Debug.Log("up swipe");
                input = Direction.forward;
            }
            //swipe down
            if (currentSwipe.y < 0 && currentSwipe.x > -0.5f && currentSwipe.x < 0.5f)
            {
                Debug.Log("down swipe");
                input = Direction.backward;
            }
            //swipe left
            if (currentSwipe.x < 0 && currentSwipe.y > -0.5f && currentSwipe.y < 0.5f)
            {
                Debug.Log("left swipe");
                input = Direction.left;
            }
            //swipe right
            if (currentSwipe.x > 0 && currentSwipe.y > -0.5f && currentSwipe.y < 0.5f)
            {
                Debug.Log("right swipe");
                input = Direction.right;

            }



        }
    }
    private Vector2 fp; // first finger position
    private Vector2 lp; // last finger position


    void TouchSwipe()
    {
        foreach (Touch touch in Input.touches)
        {
            if (touch.phase == TouchPhase.Began)
            {
                fp = touch.position;
                lp = touch.position;
            }
            if (touch.phase == TouchPhase.Moved)
            {
                lp = touch.position;
            }
            if (touch.phase == TouchPhase.Ended)
            {
                if ((fp.x - lp.x) > 50) // left swipe
                {
                    Debug.Log("left swipe here...");
                    input = Direction.left;

                }
                else if ((fp.x - lp.x) < -50) // right swipe
                {
                    Debug.Log("right swipe here...");
                    input = Direction.right;

                }
                else if ((fp.y - lp.y) < -50) // up swipe
                {
                    Debug.Log("up swipe here...");
                    input = Direction.forward;

                }
                else if ((fp.y - lp.y) > 50) // down swipe
                {
                    Debug.Log("down swipe here...");
                    input = Direction.backward;

                }
            }
        }
    }
    Vector3 Kickdirection;
    public void OnCollisionEnter(Collision collision)
    {
        if(collision.gameObject.tag=="RightLeg" || collision.gameObject.tag == "LeftLeg")
        {

            Kickdirection = this.transform.position - collision.gameObject.transform.position;
            kick = true;
        }
    }
    public void stopkickforce()
    {
        kick = false;
    }
    public Enemy[] enemuy;
    public void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Goal")
        {
            Debug.Log("levelcomplete");
            if (FindObjectsOfType<Enemy>() !=null)
            {
                enemuy = FindObjectsOfType<Enemy>();
                for (int i = 0; i < enemuy.Length; i++)
                {
                    enemuy[i].RagdollOn();
                }
            }
            if (FindObjectOfType<GoalKeeper>())
            {
                FindObjectOfType<GoalKeeper>().RagdollOn();
            }
            FindObjectOfType<InGameUi>().levelcomplete();
        }
        if (other.gameObject.tag == "Borders") 
        {
            Debug.Log("borders");
            Debug.Log(other.gameObject);
            FindObjectOfType<PlayerFollow>().stopcamera = true;
            FindObjectOfType<InGameUi>().levelfail();
        }
    }
    public void OnCollisionStay(Collision collision)
    {
     //   Debug.Log(collision.gameObject);
    }
}
