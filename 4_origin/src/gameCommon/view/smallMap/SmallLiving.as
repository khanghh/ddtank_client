package gameCommon.view.smallMap
{
   import flash.geom.Matrix;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import phy.object.SmallObject;
   
   public class SmallLiving extends SmallObject
   {
       
      
      protected var _info:Living;
      
      public function SmallLiving()
      {
         super();
      }
      
      public function set info(param1:Living) : void
      {
         _info = param1;
         fitInfo();
      }
      
      public function get info() : Living
      {
         return _info;
      }
      
      override protected function draw() : void
      {
         if(GameControl.Instance.smallMapShape() && _info)
         {
            switch(int(GameControl.Instance.randomSmallLivingShape))
            {
               case 0:
                  drawCircle();
                  break;
               case 1:
                  drawRect();
                  break;
               case 2:
                  drawTriangle();
            }
         }
         else
         {
            drawOldCircle();
         }
      }
      
      protected function drawOldCircle() : void
      {
         graphics.clear();
         graphics.beginFill(_color);
         graphics.drawCircle(0,0,_radius);
         graphics.endFill();
      }
      
      protected function drawRect() : void
      {
         var _loc2_:Array = GameControl.Instance.teamColorData[_info.team.toString()];
         var _loc3_:Array = [255,255];
         var _loc1_:Array = [0,255];
         var _loc4_:Matrix = new Matrix();
         _loc4_.createGradientBox(_radius * 2,_radius * 2);
         graphics.clear();
         graphics.beginGradientFill("linear",_loc2_,_loc3_,_loc1_,_loc4_);
         graphics.drawRect(0,-4,_radius * 2,_radius * 2);
         graphics.endFill();
      }
      
      protected function drawCircle() : void
      {
         var _loc2_:Array = GameControl.Instance.teamColorData[_info.team.toString()];
         var _loc3_:Array = [255,255];
         var _loc1_:Array = [0,255];
         var _loc4_:Matrix = new Matrix();
         _loc4_.createGradientBox(_radius * 2,_radius * 2);
         graphics.clear();
         graphics.beginGradientFill("linear",_loc2_,_loc3_,_loc1_,_loc4_);
         graphics.drawCircle(0,0,_radius);
         graphics.endFill();
      }
      
      protected function drawTriangle() : void
      {
         var _loc2_:Array = GameControl.Instance.teamColorData[_info.team.toString()];
         var _loc3_:Array = [255,255];
         var _loc1_:Array = [0,255];
         var _loc4_:Matrix = new Matrix();
         _loc4_.createGradientBox(_radius * 2,_radius * 2);
         graphics.clear();
         graphics.beginGradientFill("linear",_loc2_,_loc3_,_loc1_,_loc4_);
         graphics.moveTo(_radius,0 - _radius);
         graphics.lineTo(0,_radius);
         graphics.lineTo(_radius * 2,_radius);
         graphics.lineTo(_radius,0 - _radius);
         graphics.endFill();
      }
      
      protected function drawLinearColor() : void
      {
         var _loc2_:Array = GameControl.Instance.teamColorData[_info.team.toString()];
         var _loc3_:Array = [255,255];
         var _loc1_:Array = [0,255];
         var _loc4_:Matrix = new Matrix();
         _loc4_.createGradientBox(_radius * 2,_radius * 2);
         graphics.beginGradientFill("linear",_loc2_,_loc3_,_loc1_,_loc4_);
      }
      
      protected function fitInfo() : void
      {
         switch(int(_info.team) - 1)
         {
            case 0:
               color = 13260;
               break;
            case 1:
               color = 16711680;
               break;
            case 2:
               color = 16763904;
               break;
            case 3:
               color = 10079232;
               break;
            case 4:
               color = 6697932;
               break;
            case 5:
               color = 10053171;
               break;
            case 6:
               color = 16751052;
               break;
            default:
               color = 3381606;
         }
      }
      
      public function setColor(param1:int) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               color = 26112;
               break;
            case 1:
               color = 13260;
               break;
            case 2:
               color = 16711680;
               break;
            case 3:
               color = 10079232;
         }
      }
   }
}
