package labyrinth.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import labyrinth.LabyrinthManager;
   
   public class LabyrinthBoxIconTips extends Sprite implements ITip, Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _label:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _line:ScaleBitmapImage;
      
      public function LabyrinthBoxIconTips(){super();}
      
      private function init() : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      private function setContentText() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
