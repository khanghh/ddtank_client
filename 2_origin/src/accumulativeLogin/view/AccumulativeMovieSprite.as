package accumulativeLogin.view
{
   import accumulativeLogin.data.AccumulativeLoginRewardData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class AccumulativeMovieSprite extends Sprite implements ITipedDisplay, Disposeable
   {
       
      
      private var _state:int;
      
      private var _movieClip:MovieClip;
      
      private var _tipData:Object;
      
      private var _tipDirection:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _data:AccumulativeLoginRewardData;
      
      public function AccumulativeMovieSprite(mivieClipName:String)
      {
         super();
         tipStyle = "core.GoodsTip";
         tipDirctions = "4,1,0,5,2";
         mouseChildren = true;
         mouseEnabled = false;
         buttonMode = true;
         _movieClip = ComponentFactory.Instance.creat(mivieClipName);
         _movieClip.gotoAndStop(1);
         addChild(_movieClip);
         ShowTipManager.Instance.addTip(this);
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(value:Object) : void
      {
         _tipData = value;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirection;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirection = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeChild(_movieClip);
         _movieClip = null;
         ShowTipManager.Instance.removeTip(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set state(value:int) : void
      {
         _state = value;
         _movieClip.gotoAndStop(_state);
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get data() : AccumulativeLoginRewardData
      {
         return _data;
      }
      
      public function set data(value:AccumulativeLoginRewardData) : void
      {
         _data = value;
      }
   }
}
