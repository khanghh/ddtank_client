package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITransformableTipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionSkillInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ConsortionSkillCell extends Sprite implements Disposeable, ITransformableTipedDisplay
   {
       
      
      private var _info:ConsortionSkillInfo;
      
      private var _bg:Bitmap;
      
      public function ConsortionSkillCell(){super();}
      
      public function dispose() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function get info() : ConsortionSkillInfo{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function contentRect(param1:int, param2:int) : void{}
      
      public function setGray(param1:Boolean) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function get tipWidth() : int{return 0;}
      
      public function set tipWidth(param1:int) : void{}
      
      public function get tipHeight() : int{return 0;}
      
      public function set tipHeight(param1:int) : void{}
   }
}
