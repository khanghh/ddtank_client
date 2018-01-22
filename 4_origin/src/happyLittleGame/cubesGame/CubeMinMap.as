package happyLittleGame.cubesGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.text.TextField;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class CubeMinMap extends Sprite implements Disposeable
   {
       
      
      private var _txt:TextField;
      
      private var _sp:Sprite;
      
      private var _height:uint;
      
      private var _lastArr:Array;
      
      public function CubeMinMap()
      {
         super();
         CubeGameManager.getInstance().addEventListener("cubeDelete",freshMap);
         CubeGameManager.getInstance().addEventListener("miniMap",freshMap);
         _txt = new TextField();
         _txt.width = 320;
         _txt.height = 20;
         _txt.wordWrap = false;
         _txt.textColor = 16711680;
         _txt.x = 13;
         _txt.y = -20;
         _sp = new Sprite();
         this.addChild(_sp);
      }
      
      private function freshMap(param1:CubeGameEvent) : void
      {
         var _loc6_:* = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(this.numChildren > 1)
         {
            this.removeChildren(1,this.numChildren - 1);
         }
         var _loc3_:Array = new Array(CubeGameManager.getInstance().gameInfo.column);
         var _loc5_:Array = param1.data as Array;
         lastMap();
         _lastArr = _loc5_.concat();
         _height = 0;
         _loc6_ = uint(0);
         while(_loc6_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc6_];
            if(!(!_loc4_ || _loc4_.type == 0))
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.CubeGame." + _loc4_.type);
               _loc2_.width = 20.5;
               _loc2_.height = 21;
               _loc2_.x = (CubeGameManager.getInstance().gameInfo.column - _loc4_.x) * 41 * 0.5;
               _loc2_.y = _loc4_.y * 42 * 0.5;
               _height = _loc2_.y;
               this.addChild(_loc2_);
               _loc3_[_loc4_.x] = _loc4_;
            }
            _loc6_++;
         }
      }
      
      private function lastMap() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_sp.numChildren > 0)
         {
            _sp.removeChildren(0,_sp.numChildren - 1);
         }
         if(!_lastArr)
         {
            return;
         }
         _height = 20;
         _sp.y = 20;
         _loc3_ = uint(0);
         while(_loc3_ < _lastArr.length)
         {
            _loc2_ = _lastArr[_loc3_];
            if(!(!_loc2_ || _loc2_.type == 0))
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.CubeGame." + _loc2_.type);
               _loc1_.width = 20.5;
               _loc1_.height = 21;
               _loc1_.x = (CubeGameManager.getInstance().gameInfo.column - _loc2_.x) * 41 * 0.5;
               _loc1_.y = 250 + _loc2_.y * 42 * 0.5;
               _sp.addChild(_loc1_);
            }
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         CubeGameManager.getInstance().removeEventListener("cubeDelete",freshMap);
         CubeGameManager.getInstance().removeEventListener("miniMap",freshMap);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
