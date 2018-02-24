package happyLittleGame.bombshellGame.item
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import uiModeManager.bombUI.BulletDirection;
   
   public class BombGameBullet extends Sprite implements Disposeable
   {
       
      
      private var bullet:MovieClip;
      
      private var direc:int;
      
      private var vx:int;
      
      private var vy:int;
      
      private var moveConst:Number = 10;
      
      private var offx:int = 25;
      
      private var offy:int = 25;
      
      private var _order:int;
      
      public function BombGameBullet(param1:int, param2:int, param3:int, param4:int, param5:int){super();}
      
      public function get order() : int{return 0;}
      
      public function set order(param1:int) : void{}
      
      public function get MC() : MovieClip{return null;}
      
      private function initDirec(param1:int, param2:int) : void{}
      
      public function get Direc() : int{return 0;}
      
      public function get VX() : int{return 0;}
      
      public function get VY() : int{return 0;}
      
      public function BulletMc() : void{}
      
      public function dispose() : void{}
   }
}
