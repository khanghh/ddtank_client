package guardCore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import guardCore.GuardCoreManager;
   import guardCore.data.GuardCoreInfo;
   
   public class GuardCoreTips extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _name:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      private var _keepTurn:FilterFrameText;
      
      private var _next:FilterFrameText;
      
      private var _nextGrade:FilterFrameText;
      
      private var _nextDescribe:FilterFrameText;
      
      private var _nextKeepTurn:FilterFrameText;
      
      private var _type:int;
      
      private var _grade:int;
      
      private var _guardGrade:int;
      
      private var _vBox:VBox;
      
      private const RED:uint = 16711680;
      
      private const GREEN:uint = 1895424;
      
      public function GuardCoreTips(){super();}
      
      override protected function init() : void{}
      
      private function updateView() : void{}
      
      private function resetTextSize(param1:FilterFrameText) : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      private function getLine() : Image{return null;}
      
      override public function get tipData() : Object{return null;}
      
      override public function dispose() : void{}
   }
}
