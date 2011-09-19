
// 拖拽窗体上的控件

int x0, y0;

private void button1_MouseDown(object sender, MouseEventArgs e)
{
  x0 = e.X;
  y0 = e.Y;
}

private void button1_MouseMove(object sender, MouseEventArgs e)
{
  if (e.Button == MouseButtons.Left)
    {
      Point p0 = this.button1.Location;
      this.button1.Location = new Point(p0.X + e.X - x0, p0.Y + e.Y - y0);
    }

}
