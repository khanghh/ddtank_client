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
      
      public function BombGameBullet(_direc:int, _vx:int, _vy:int, _x:int, _y:int)
      {
         super();
         bullet = ClassUtils.CreatInstance("asset.bombgame.bullet");
         offx = bullet.width / 2 + 27;
         offy = bullet.height / 2 + 27;
         direc = _direc;
         vx = _vx;
         vy = _vy;
         initDirec(_x,_y);
         addChild(bullet);
      }
      
      public function get order() : int
      {
         return _order;
      }
      
      public function set order(value:int) : void
      {
         _order = value;
      }
      
      public function get MC() : MovieClip
      {
         return bullet;
      }
      
      private function initDirec(_x:int, _y:int) : void
      {
         var _loc3_:* = direc;
         if(BulletDirection.Down !== _loc3_)
         {
            if(BulletDirection.Up !== _loc3_)
            {
               if(BulletDirection.Left !== _loc3_)
               {
                  if(BulletDirection.Right === _loc3_)
                  {
                     bullet.rotation = 0;
                     x = _x;
                     y = _y;
                  }
               }
               else
               {
                  bullet.rotation = 180;
                  x = _x;
                  y = _y;
               }
            }
            else
            {
               bullet.rotation = 270;
               x = _x;
               y = _y;
            }
         }
         else
         {
            bullet.rotation = 90;
            x = _x;
            y = _y;
         }
      }
      
      public function get Direc() : int
      {
         return direc;
      }
      
      public function get VX() : int
      {
         return vx;
      }
      
      public function get VY() : int
      {
         return vy;
      }
      
      public function BulletMc() : void
      {
         var _loc1_:* = direc;
         if(BulletDirection.Down !== _loc1_)
         {
            if(BulletDirection.Up !== _loc1_)
            {
               if(BulletDirection.Left !== _loc1_)
               {
                  if(BulletDirection.Right === _loc1_)
                  {
                     x = x + moveConst;
                  }
               }
               else
               {
                  x = x - moveConst;
               }
            }
            else
            {
               y = y - moveConst;
            }
         }
         else
         {
            y = y + moveConst;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(bullet);
         bullet = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
