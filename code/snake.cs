using System; 
using System.Drawing; 
using System.Collections; 
using System.ComponentModel; 
using System.Windows.Forms; 
using System.Data; 


namespace SNAKE 
{ 
    /// <summary> 
    /// Form1 的摘要说明。 
    /// </summary> 
    public class Form1 : System.Windows.Forms.Form 
    { 
	private System.Windows.Forms.Timer timer1; 
	private System.Windows.Forms.MainMenu mainMenu1; 
	private System.Windows.Forms.MenuItem menuGame; 
	private System.Windows.Forms.MenuItem menuStart; 
	private System.Windows.Forms.MenuItem menuPause; 
	private System.Windows.Forms.MenuItem menuItem4; 
	private System.Windows.Forms.MenuItem menuExit; 
	private System.Windows.Forms.MenuItem menuConfig; 
	private System.Windows.Forms.MenuItem menuLevel; 
	private System.ComponentModel.IContainer components; 
	private System.Windows.Forms.MenuItem menuItem8; 
	private System.Windows.Forms.MenuItem menuItem9; 
	private System.Windows.Forms.MenuItem menuItem10; 
	private System.Windows.Forms.MenuItem menuItem11; 
	private System.Windows.Forms.MenuItem menuItem12; 
	private System.Windows.Forms.Label label3; 
	private System.Windows.Forms.Label label4; 
	private System.Windows.Forms.Label label5; 
	private System.Windows.Forms.Label label6; 
	private System.Windows.Forms.MenuItem menuHelp; 
	private System.Windows.Forms.MenuItem menuAbout; 
	private System.Windows.Forms.Label label1; 

	private int SnkWidth = 16; //蛇的每个点的宽度 
	private static int SnakeMaxLength = 500; //蛇最大的长度 
	public Point[] SnkLct=new Point[SnakeMaxLength];  
	public int SnkLen; //蛇的长度 
	public int speed=150; //蛇爬行的速度 
	public byte SnkDrt=2; //蛇爬行的方向，1:上，2:右，3:下，4:左 
	public Point FoodLct=new Point(); 
	public int score=0; //得分 
	public bool pause; //暂停标志位 


	public Form1() 
	    { 
		// 
		// Windows 窗体设计器支持所必需的 
		// 
		InitializeComponent(); 

		// 
		// TODO: 在 InitializeComponent 调用后添加任何构造函数代码 
		// 
	    } 

	/// <summary> 
	/// 清理所有正在使用的资源。 
	/// </summary> 
	protected override void Dispose( bool disposing ) 
	{ 
	    if( disposing ) 
		{ 
		    if(components != null)  
			{ 
			    components.Dispose(); 
			} 
		} 
	    base.Dispose( disposing ); 
	} 

	#region Windows 窗体设计器生成的代码 
	    /// <summary> 
	    /// 设计器支持所需的方法 - 不要使用代码编辑器修改 
	    /// 此方法的内容。 
	    /// </summary> 
	    private void InitializeComponent() 
	    { 
		this.components = new System.ComponentModel.Container(); 
		this.timer1 = new System.Windows.Forms.Timer(this.components); 
		this.mainMenu1 = new System.Windows.Forms.MainMenu(); 
		this.menuGame = new System.Windows.Forms.MenuItem(); 
		this.menuStart = new System.Windows.Forms.MenuItem(); 
		this.menuPause = new System.Windows.Forms.MenuItem(); 
		this.menuItem4 = new System.Windows.Forms.MenuItem(); 
		this.menuExit = new System.Windows.Forms.MenuItem(); 
		this.menuConfig = new System.Windows.Forms.MenuItem(); 
		this.menuLevel = new System.Windows.Forms.MenuItem(); 
		this.menuItem8 = new System.Windows.Forms.MenuItem();
		this.menuItem9 = new System.Windows.Forms.MenuItem(); 
		this.menuItem10 = new System.Windows.Forms.MenuItem(); 
		this.menuItem11 = new System.Windows.Forms.MenuItem(); 
		this.menuItem12 = new System.Windows.Forms.MenuItem(); 
		this.menuHelp = new System.Windows.Forms.MenuItem(); 
		this.menuAbout = new System.Windows.Forms.MenuItem(); 
		this.label1 = new System.Windows.Forms.Label(); 
		this.label3 = new System.Windows.Forms.Label(); 
		this.label4 = new System.Windows.Forms.Label(); 
		this.label5 = new System.Windows.Forms.Label(); 
		this.label6 = new System.Windows.Forms.Label(); 
		this.SuspendLayout(); 
		//  
		// timer1 
		//  
		this.timer1.Tick += new System.EventHandler(this.timer1_Tick); 
		//  
		// mainMenu1 
		//  
		this.mainMenu1.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] { 
			this.menuGame, 
			this.menuConfig, 
			this.menuHelp}); 
		//  
		// menuGame 
		//  
		this.menuGame.Index = 0; 
		this.menuGame.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] { 
			this.menuStart, 
			this.menuPause, 
			this.menuItem4, 
			this.menuExit}); 
		this.menuGame.Text = "游戏(&G)"; 
		//  
		// menuStart 
		//  
		this.menuStart.Index = 0; 
		this.menuStart.Text = "开始"; 
		this.menuStart.Click += new System.EventHandler(this.menuStart_Click); 
		//  
		// menuPause 
		//  
		this.menuPause.Enabled = false; 
		this.menuPause.Index = 1; 
		this.menuPause.Text = "暂停"; 
		this.menuPause.Click += new System.EventHandler(this.menuPause_Click); 
		//  
		// menuItem4 
		//  
		this.menuItem4.Index = 2; 
		this.menuItem4.Text = "-"; 
		//  
		// menuExit 
		//  
		this.menuExit.Index = 3; 
		this.menuExit.Text = "退出"; 
		this.menuExit.Click += new System.EventHandler(this.menuExit_Click); 
		//  
		// menuConfig 
		//  
		this.menuConfig.Index = 1; 
		this.menuConfig.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] { 
			this.menuLevel}); 
		this.menuConfig.Text = "设置(&S)"; 
		//  
		// menuLevel 
		//  
		this.menuLevel.Index = 0; 
		this.menuLevel.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] { 
			this.menuItem8, 
			this.menuItem9, 
			this.menuItem10, 
			this.menuItem11, 
			this.menuItem12}); 
		this.menuLevel.Text = "难度"; 
		//  
		// menuItem8 
		//  
		this.menuItem8.Index = 0; 
		this.menuItem8.Text = "最快"; 
		this.menuItem8.Click += new System.EventHandler(this.menuItem8_Click); 
		//  
		// menuItem9 
		//  
		this.menuItem9.Index = 1; 
		this.menuItem9.Text = "较快"; 
		this.menuItem9.Click += new System.EventHandler(this.menuItem9_Click); 
		//  
		// menuItem10 
		//  
		this.menuItem10.Index = 2; 
		this.menuItem10.Text = "普通"; 
		this.menuItem10.Click += new System.EventHandler(this.menuItem10_Click); 
		//  
		// menuItem11
		//  
		this.menuItem11.Index = 3; 
		this.menuItem11.Text = "较慢"; 
		this.menuItem11.Click += new System.EventHandler(this.menuItem11_Click); 
		//  
		// menuItem12 
		//  
		this.menuItem12.Index = 4; 
		this.menuItem12.Text = "最慢"; 
		this.menuItem12.Click += new System.EventHandler(this.menuItem12_Click); 
		//  
		// menuHelp 
		//  
		this.menuHelp.Index = 2; 
		this.menuHelp.MenuItems.AddRange(new System.Windows.Forms.MenuItem[] { 
			this.menuAbout}); 
		this.menuHelp.Text = "帮助(&H)"; 
		//  
		// menuAbout 
		//  
		this.menuAbout.Index = 0; 
		this.menuAbout.Text = "关于..."; 
		this.menuAbout.Click += new System.EventHandler(this.menuAbout_Click); 
		//  
		// label1 
		//  
		this.label1.BackColor = System.Drawing.Color.Red; 
		this.label1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D; 
		this.label1.ForeColor = System.Drawing.Color.DarkRed; 
		this.label1.Location = new System.Drawing.Point(620, 16); 
		this.label1.Name = "label1"; 
		this.label1.Size = new System.Drawing.Size(15, 15); 
		this.label1.TabIndex = 0; 
		//  
		// label3 
		//  
		this.label3.BackColor = System.Drawing.Color.Red; 
		this.label3.Location = new System.Drawing.Point(0, 1); 
		this.label3.Name = "label3"; 
		this.label3.Size = new System.Drawing.Size(609, 1); 
		this.label3.TabIndex = 2; 
		this.label3.Text = "label3"; 
		//  
		// label4 
		//  
		this.label4.BackColor = System.Drawing.Color.Red; 
		this.label4.Location = new System.Drawing.Point(0, 449); 
		this.label4.Name = "label4"; 
		this.label4.Size = new System.Drawing.Size(609, 1); 
		this.label4.TabIndex = 2; 
		this.label4.Text = "label3"; 
		//  
		// label5 
		//  
		this.label5.BackColor = System.Drawing.Color.Red; 
		this.label5.Location = new System.Drawing.Point(0, 1); 
		this.label5.Name = "label5"; 
		this.label5.Size = new System.Drawing.Size(1, 449); 
		this.label5.TabIndex = 2; 
		this.label5.Text = "label3"; 
		//  
		// label6 
		//  
		this.label6.BackColor = System.Drawing.Color.Red; 
		this.label6.Location = new System.Drawing.Point(608, 1); 
		this.label6.Name = "label6"; 
		this.label6.Size = new System.Drawing.Size(1, 449); 
		this.label6.TabIndex = 2; 
		this.label6.Text = "label3"; 
		//  
		// Form1 
		//  
		this.AutoScaleBaseSize = new System.Drawing.Size(6, 14); 
		this.BackColor = System.Drawing.Color.Black; 
		this.ClientSize = new System.Drawing.Size(610, 451); 
		this.Controls.Add(this.label3); 
		this.Controls.Add(this.label1); 
		this.Controls.Add(this.label4); 
		this.Controls.Add(this.label5); 
		this.Controls.Add(this.label6); 
		this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D; 
		this.MaximizeBox = false; 
		this.Menu = this.mainMenu1; 
		this.Name = "Form1"; 
		this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen; 
		this.Text = "贪食蛇 v1.0.4 当前得分 : 0"; 
		this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Form1_KeyDown); 
		//this.Load += new System.EventHandler(this.Form1_Load);
		this.ResumeLayout(false); 

	    } 
	#endregion 

	    /// <summary> 
	    /// 应用程序的主入口点。 
	    /// </summary> 
	    [STAThread] 
	    static void Main()  
	    { 
		Application.Run(new Form1()); 
	    } 

	private void Drawshape(int x,int y) 
	{ 
	    System.Drawing.Graphics g; 
	    g=this.CreateGraphics(); 
	    //g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality; 
	    Pen pen1=new Pen(Color.Green,1);//定义画笔 
	    SolidBrush brush1=new SolidBrush(Color.Blue);//定义画刷 
	    g.DrawRectangle(pen1,x,y,15,15);//画一个高宽都是１５的方块 
	    g.FillRectangle(brush1,x,y,15,15); //用蓝色填充上面这个方块 
	} 

	//显示食物 
	private void Food() 
	{ 
	    Random rmd=new Random(); 
	    //画点的方法不行，因为后面要清屏 
	    //通过设置Label的位置来显示食物 
	    int w,h,x,y; 
	    w = Convert.ToInt32(Math.Floor(this.ClientSize.Width / 16.0)) - 1; 
	    h = Convert.ToInt32(Math.Floor(this.ClientSize.Height / 16.0)) - 1; 
	    x = rmd.Next(0,w)*SnkWidth;//610 
	    y = rmd.Next(0,h)*SnkWidth;//451 
	    // x = rmd.Next(0,37)*SnkWidth;//610 
	    // y = rmd.Next(0,27)*SnkWidth;//451 
	    while(CheckInSnakeBody(x,y,1)) 
		{ 
		    x = rmd.Next(0,w)*SnkWidth;//610 
		    y = rmd.Next(0,h)*SnkWidth;//451 
		} 

	    Point pt=new Point(); 
	    pt.X = x; 
	    pt.Y = y; 
	    label1.Location=pt; 
	    FoodLct.X=pt.X; 
	    FoodLct.Y=pt.Y; 
	} 

	//检查输入的坐标是否在蛇身上 
	//snkHead用于设置循环开始的值，因为判断DEAD的时候不能检查蛇头，必须从2开始 
	private bool CheckInSnakeBody(int x,int y,int snkHead) 
	{ 
	    for(int i=snkHead ;i<=SnkLen;i++) 
		{//判断是否在蛇身上了 
		    if(x ==SnkLct[i].X && y == SnkLct[i].Y) 
			return true; 
		} 
	    return false; 
	} 

	private bool Eated() 
	{ 
	    if(SnkLct[1].X ==FoodLct.X && SnkLct[1].Y ==FoodLct.Y) 
		{ 
		    if(SnkLen < SnakeMaxLength) 
			{ 
			    SnkLen++; 
			    SnkLct[SnkLen].X=SnkLct[SnkLen-1].X ; 
			    SnkLct[SnkLen].Y=SnkLct[SnkLen-1].Y ; 
			} 
		    score+=10; 
		    return true; 
		} 
	    else 
		return false; 

	} 

	private bool Dead() 
	{ 
	    if(CheckInSnakeBody(SnkLct[1].X,SnkLct[1].Y,2)) 
		return true; 
  
	    // if(SnkLct[1].X >592 || SnkLct[1].Y >432 || SnkLct[1].X <0 || SnkLct[1].Y<0) 
	    if(SnkLct[1].X >(this.ClientSize.Width-15) || SnkLct[1].Y >(this.ClientSize.Height-15) || SnkLct[1].X <0 || SnkLct[1].Y<0) 
		return true; 
	    else 
		return false; 
	} 
	private void Forward(int drc) 
	{ 

	    Point tmp=new Point(); 
	    tmp.X =SnkLct[1].X ; 
	    tmp.Y =SnkLct[1].Y ; 
	    for(int i=SnkLen;i>1;i--) 
		{//蛇头动，把蛇头的坐标逐个后移(蛇身往蛇头方向位移) 
		    SnkLct[i].X =SnkLct[i-1].X ; 
		    SnkLct[i].Y =SnkLct[i-1].Y ; 
		} 

	    switch(drc) 
		{//根据设置的方向，计算蛇头的坐标 
		case 1: 
		    SnkLct[1].X =tmp.X ; 
		    SnkLct[1].Y =tmp.Y-SnkWidth ; 
		    break; //上 
		case 2: 
		    SnkLct[1].X =tmp.X+SnkWidth ; 
		    SnkLct[1].Y =tmp.Y ; 
		    break; //右 
		case 3: 
		    SnkLct[1].X =tmp.X ; 
		    SnkLct[1].Y =tmp.Y+SnkWidth ; 
		    break; //下 
		case 4: 
		    SnkLct[1].X =tmp.X-SnkWidth ; 
		    SnkLct[1].Y =tmp.Y ; 
		    break; //左 
		} 
	    for(int i=1;i<=SnkLen;i++) 
		{//逐个点画蛇 
		    Drawshape(SnkLct[i].X ,SnkLct[i].Y ); 
		} 
	} 

	private void GameInit() 
	{ 
	    pause = false; 
	    menuPause.Checked = false; 

	    score = 0;//初始化得分 
	    int startl=0;//尾巴的起点 
	    SnkLen=5; //蛇的初始长度，５个点 
	    for(int i=5;i>=1;i--) 
		{//分别设置蛇每个点的坐标位置 
		    SnkLct[i].X =startl; 
		    SnkLct[i].Y=0; 
		    startl+=SnkWidth; 
		} 
	    SnkDrt=2;//蛇的初始方向是向右 

	} 
  
	//游戏开始 
	private void menuStart_Click(object sender, System.EventArgs e) 
	{ 
	    GameInit(); //点击开始时初始化 

	    //画蛇 
	    Forward(SnkDrt); 

	    timer1.Interval = speed; 
	    timer1.Enabled=true; 
	    Food();//显示食物 
	    menuPause.Enabled=true; 
	} 

	private void timer1_Tick(object sender, System.EventArgs e) 
	{ 

	    System.Drawing.Graphics g; 
	    g=this.CreateGraphics(); 
	    g.Clear(Color.Black);//清除整个画面 
	    Forward(SnkDrt); 
	    if(Eated()) 
		{ 
		    Food(); 
		} 
	    this.Text = this.Text.Substring(0,this.Text.IndexOf(" : ") + 3) + score.ToString(); 

	    if(Dead())  
		{ 
		    timer1.Enabled=false; 
		    MessageBox.Show("游戏结束！！\n"+"得分："+score,"",MessageBoxButtons.OK ,MessageBoxIcon.Information ); 
		} 


	} 

	private void menuItem8_Click(object sender, System.EventArgs e) 
	{ 
	    timer1.Interval=50; 
	    speed=30; 
	} 

	private void menuItem9_Click(object sender, System.EventArgs e) 
	{ 
	    timer1.Interval=100; 
	    speed=100; 
	} 

	private void menuItem10_Click(object sender, System.EventArgs e) 
	{ 
	    timer1.Interval=150; 
	    speed=150; 
	} 

	private void menuItem11_Click(object sender, System.EventArgs e) 
	{ 
	    timer1.Interval=200; 
	    speed=200; 
	} 

	private void menuItem12_Click(object sender, System.EventArgs e) 
	{ 
	    timer1.Interval=300; 
	    speed=300; 
	} 

	private void menuPause_Click(object sender, System.EventArgs e) 
	{ 
	    if(pause==false) 
		{ 
		    pause=true; 
		    timer1.Enabled =false; 
		    menuPause.Checked =pause; 
		} 
	    else 
		{ 
		    pause=false; 
		    timer1.Enabled =true; 
		    menuPause.Checked =pause; 
		} 
	} 

	private void menuExit_Click(object sender, System.EventArgs e) 
	{ 
	    this.Close(); 
	} 

	private void menuAbout_Click(object sender, System.EventArgs e) 
	{ 
	    MessageBox.Show("贪食蛇游戏 v1.0.4 beta \n"+ "操作方法：用方向键或小键盘8、5、4、6控制方向\n　　　　　S健开始\n　　　　　P健暂停。", 
			    "帮助",MessageBoxButtons.OK ,MessageBoxIcon.Information ); 
	} 

	//监控键盘操作蛇的方向 
	private void Form1_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e) 
	{ 
	    string key = e.KeyCode.ToString(); 
	    switch(key) 
		{ 
		case "Up": 
		case "NumPad8": 
		    { 
			if(SnkDrt!=3) 
			    SnkDrt=1; 
			break; 
		    } 
		case "Right": 
		case "NumPad6": 
		    { 
			if(SnkDrt!=4)  
			    SnkDrt=2; 
			break; 
		    } 
		case "Down": 
		case "NumPad5": 
		case "Clear": 
		    if(SnkDrt!=1) 
			SnkDrt=3; 
		break; 

		case "Left": 
		case "NumPad4": 
		    if(SnkDrt!=2) 
			SnkDrt=4; 
		break; 
		case "": 
		    menuPause_Click(null,null); 
		    break; 
		case "S": 
		    menuStart_Click(null,null); 
		    break; 
		} 
	} 

    } 

} 
