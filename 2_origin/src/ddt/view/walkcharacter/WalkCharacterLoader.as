package ddt.view.walkcharacter
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.DisplayUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.view.character.ILayer;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WalkCharacterLoader extends EventDispatcher implements Disposeable
   {
      
      public static const CellCharaterWidth:int = 120;
      
      public static const CellCharaterHeight:int = 175;
      
      private static const standFrams:Array = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1];
      
      private static const backFrame:Array = [3];
      
      private static const walkFrontFrame:Array = [3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8];
      
      private static const walkBackFrame:Array = [10,10,10,11,11,11,12,12,12,13,13,13,14,14,14];
      
      public static const FrameLabels:Array = [{
         "frame":1,
         "name":"stand"
      },{
         "frame":standFrams.length - 1,
         "name":"gotoAndPlay(stand)"
      },{
         "frame":standFrams.length,
         "name":"back"
      },{
         "frame":standFrams.length + backFrame.length,
         "name":"walkfront"
      },{
         "frame":standFrams.length + backFrame.length + walkFrontFrame.length - 1,
         "name":"gotoAndPlay(walkfront)"
      },{
         "frame":standFrams.length + backFrame.length + walkFrontFrame.length,
         "name":"walkback"
      },{
         "frame":standFrams.length + backFrame.length + walkFrontFrame.length + walkBackFrame.length - 1,
         "name":"gotoAndPlay(walkback)"
      }];
      
      public static const UsedFrame:Array = standFrams.concat(backFrame,walkFrontFrame,walkBackFrame);
      
      public static const Stand:String = "stand";
      
      public static const Back:String = "back";
      
      public static const WalkFront:String = "walkfront";
      
      public static const WalkBack:String = "walkback";
       
      
      private var _resultBitmapData:BitmapData;
      
      private var _layers:Vector.<WalkCharaterLayer>;
      
      private var _playerInfo:PlayerInfo;
      
      private var _recordStyle:Array;
      
      private var _recordColor:Array;
      
      private var _clothPath:String;
      
      public function WalkCharacterLoader(param1:PlayerInfo, param2:String)
      {
         super();
         _clothPath = param2;
         _playerInfo = param1;
      }
      
      public function load() : void
      {
         var _loc2_:int = 0;
         _layers = new Vector.<WalkCharaterLayer>();
         if(_playerInfo == null || _playerInfo.Style == null)
         {
            return;
         }
         initLoaders();
         var _loc1_:int = _layers.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _layers[_loc2_].load(layerComplete);
            _loc2_++;
         }
      }
      
      private function initLoaders() : void
      {
         _layers = new Vector.<WalkCharaterLayer>();
         _recordStyle = _playerInfo.Style.split(",");
         _recordColor = _playerInfo.Colors.split(",");
         _layers.push(new WalkCharaterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[5].split("|")[0])),_recordColor[5]));
         _layers.push(new WalkCharaterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[2].split("|")[0])),_recordColor[2]));
         _layers.push(new WalkCharaterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[3].split("|")[0])),_recordColor[3]));
         _layers.push(new WalkCharaterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],1,_playerInfo.Sex,_clothPath));
         _layers.push(new WalkCharaterLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[4].split("|")[0])),_recordColor[4],2,_playerInfo.Sex,_clothPath));
      }
      
      private function layerComplete(param1:ILayer) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _layers.length)
         {
            if(!_layers[_loc3_].isComplete)
            {
               _loc2_ = false;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            loadComplete();
         }
      }
      
      private function loadComplete() : void
      {
         drawFrame = function(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int = 0):void
         {
            var _loc8_:Rectangle = new Rectangle();
            _loc8_.width = 120;
            _loc8_.height = 175;
            var _loc7_:Point = new Point();
            _loc7_.x = param1 * 120;
            if(param2 <= 6)
            {
               _loc8_.x = param4 * 120;
               _loc8_.y = 0;
               _loc7_.y = param6;
               _resultBitmapData.copyPixels(face,_loc8_,_loc7_,null,null,true);
               _loc8_.x = param3 * 120;
               _resultBitmapData.copyPixels(hair,_loc8_,_loc7_,null,null,true);
               _loc8_.x = param5 * 120;
               _resultBitmapData.copyPixels(eff,_loc8_,_loc7_,null,null,true);
               _loc8_.x = param2 * 120;
               _loc7_.y = 0;
               _resultBitmapData.copyPixels(clothFront,_loc8_,_loc7_,null,null,true);
            }
            else
            {
               _loc8_.x = (param2 - 7) * 120;
               _loc8_.y = 175;
               _resultBitmapData.copyPixels(clothBack,_loc8_,_loc7_,null,null,true);
               _loc8_.x = param4 * 120;
               _loc8_.y = 0;
               _loc7_.y = param6;
               _resultBitmapData.copyPixels(face,_loc8_,_loc7_,null,null,true);
               _loc8_.x = param3 * 120;
               _resultBitmapData.copyPixels(hair,_loc8_,_loc7_,null,null,true);
               _loc8_.x = param5 * 120;
               _resultBitmapData.copyPixels(eff,_loc8_,_loc7_,null,null,true);
            }
         };
         var eff:BitmapData = DisplayUtils.getDisplayBitmapData(_layers[2]);
         var face:BitmapData = DisplayUtils.getDisplayBitmapData(_layers[0]);
         var hair:BitmapData = DisplayUtils.getDisplayBitmapData(_layers[1]);
         var clothFront:BitmapData = DisplayUtils.getDisplayBitmapData(_layers[3]);
         var clothBack:BitmapData = DisplayUtils.getDisplayBitmapData(_layers[4]);
         _resultBitmapData = new BitmapData(120 * 15,175,true,16711680);
         drawFrame(0,0,0,0,0);
         drawFrame(1,0,1,1,1);
         drawFrame(2,7,2,2,2);
         drawFrame(3,1,0,0,0);
         drawFrame(4,2,0,0,0);
         drawFrame(5,3,0,0,0,2);
         drawFrame(6,4,0,0,0);
         drawFrame(7,5,0,0,0);
         drawFrame(8,6,0,0,0,2);
         drawFrame(9,8,2,2,2);
         drawFrame(10,9,2,2,2);
         drawFrame(11,10,2,2,2,2);
         drawFrame(12,11,2,2,2);
         drawFrame(13,12,2,2,2);
         drawFrame(14,13,2,2,2,2);
         dispatchEvent(new Event("complete"));
      }
      
      public function get content() : BitmapData
      {
         return _resultBitmapData;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _resultBitmapData.dispose();
         _loc1_ = 0;
         while(_loc1_ < _layers.length)
         {
            _layers[_loc1_].dispose();
            _loc1_++;
         }
         _layers = null;
         _recordStyle = null;
         _recordColor = null;
         _playerInfo = null;
      }
   }
}
