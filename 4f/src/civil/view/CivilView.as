package civil.view
{
   import civil.CivilController;
   import civil.CivilModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class CivilView extends Sprite implements Disposeable
   {
       
      
      private var _civilBg:MovieClip;
      
      private var _civilLeftView:CivilLeftView;
      
      private var _civilRightView:CivilRightView;
      
      private var _controller:CivilController;
      
      private var _model:CivilModel;
      
      private var _chatFrame:Sprite;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _titleText:Bitmap;
      
      public function CivilView(param1:CivilController, param2:CivilModel){super();}
      
      private function init() : void{}
      
      public function dispose() : void{}
   }
}
