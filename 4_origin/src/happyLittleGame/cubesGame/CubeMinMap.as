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
      
      private function freshMap(evt:CubeGameEvent) : void
      {
         var i:* = 0;
         var data:* = null;
         var bmd:* = null;
         if(this.numChildren > 1)
         {
            this.removeChildren(1,this.numChildren - 1);
         }
         var columnNums:Array = new Array(CubeGameManager.getInstance().gameInfo.column);
         var cubes:Array = evt.data as Array;
         lastMap();
         _lastArr = cubes.concat();
         _height = 0;
         for(i = uint(0); i < cubes.length; )
         {
            data = cubes[i];
            if(!(!data || data.type == 0))
            {
               bmd = ComponentFactory.Instance.creatBitmap("asset.CubeGame." + data.type);
               bmd.width = 20.5;
               bmd.height = 21;
               bmd.x = (CubeGameManager.getInstance().gameInfo.column - data.x) * 41 * 0.5;
               bmd.y = data.y * 42 * 0.5;
               _height = bmd.y;
               this.addChild(bmd);
               columnNums[data.x] = data;
            }
            i++;
         }
      }
      
      private function lastMap() : void
      {
         var i:* = 0;
         var data:* = null;
         var bmd:* = null;
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
         for(i = uint(0); i < _lastArr.length; )
         {
            data = _lastArr[i];
            if(!(!data || data.type == 0))
            {
               bmd = ComponentFactory.Instance.creatBitmap("asset.CubeGame." + data.type);
               bmd.width = 20.5;
               bmd.height = 21;
               bmd.x = (CubeGameManager.getInstance().gameInfo.column - data.x) * 41 * 0.5;
               bmd.y = 250 + data.y * 42 * 0.5;
               _sp.addChild(bmd);
            }
            i++;
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
