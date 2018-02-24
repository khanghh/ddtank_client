package gameStarling.view.buff
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.StarlingObjectUtils;
   import ddt.view.tips.PropTxtTipInfo;
   import gameCommon.model.FightBuffInfo;
   import gameCommon.view.buff.FightContainerBuff;
   import road7th.StarlingMain;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class BuffCell3D extends Sprite
   {
       
      
      private var _info:FightBuffInfo;
      
      private var _tipData:PropTxtTipInfo;
      
      private var _txt:TextField;
      
      private var _buffAnimation:BoneMovieStarling;
      
      private var _image:Image;
      
      public function BuffCell3D(){super();}
      
      override public function dispose() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function clearSelf() : void{}
      
      public function setInfo(param1:FightBuffInfo) : void{}
      
      public function get tipData() : Object{return null;}
      
      private function isContainerBuff(param1:FightBuffInfo) : Boolean{return false;}
      
      private function isActivityDunBuff(param1:FightBuffInfo) : Boolean{return false;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
   }
}
