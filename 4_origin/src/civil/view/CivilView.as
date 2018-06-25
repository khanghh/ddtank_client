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
      
      public function CivilView(controller:CivilController, model:CivilModel)
      {
         super();
         _controller = controller;
         _model = model;
         init();
      }
      
      private function init() : void
      {
         _civilBg = ClassUtils.CreatInstance("asset.ddtcivil.Bg") as MovieClip;
         PositionUtils.setPos(_civilBg,"ddtcivil.bgPos");
         addChild(_civilBg);
         _civilLeftView = new CivilLeftView(_controller,_model);
         _civilRightView = new CivilRightView(_controller,_model);
         ChatManager.Instance.state = 14;
         _chatFrame = ChatManager.Instance.view;
         addChild(_civilLeftView);
         addChild(_civilRightView);
         addChild(_chatFrame);
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("asset.ddtcivil.titleBgImg");
         _titleText = ComponentFactory.Instance.creatBitmap("asset.ddtcivil.titleText");
         addChild(_titleBg);
         addChild(_titleText);
      }
      
      public function dispose() : void
      {
         if(_civilBg)
         {
            ObjectUtils.disposeObject(_civilBg);
            _civilBg = null;
         }
         if(_civilLeftView)
         {
            ObjectUtils.disposeObject(_civilLeftView);
            _civilLeftView = null;
         }
         if(_civilRightView)
         {
            ObjectUtils.disposeObject(_civilRightView);
            _civilRightView = null;
         }
         if(_titleBg)
         {
            ObjectUtils.disposeObject(_titleBg);
            _titleBg = null;
         }
         if(_titleText)
         {
            ObjectUtils.disposeObject(_titleText);
            _titleText = null;
         }
         _chatFrame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
