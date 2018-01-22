package rescue.components
{
   import catchInsect.data.RescueSceneInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RescueSceneItem extends Sprite implements Disposeable
   {
       
      
      private var _light:Bitmap;
      
      private var _bg:ScaleFrameImage;
      
      private var _sceneNum:Bitmap;
      
      private var _star:Bitmap;
      
      private var _hBox:HBox;
      
      private var _sceneId:int;
      
      private var _info:RescueSceneInfo;
      
      public function RescueSceneItem()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("rescue.sceneItemBg");
         addChild(_bg);
         _light = ComponentFactory.Instance.creat("rescue.selectedLight");
         addChild(_light);
         _light.visible = false;
         _bg.setFrame(1);
      }
      
      private function initEvents() : void
      {
      }
      
      public function setData(param1:Boolean, param2:int = 0, param3:RescueSceneInfo = null) : void
      {
         var _loc4_:int = 0;
         if(param1)
         {
            if(_sceneId != param2)
            {
               _sceneId = param2;
               ObjectUtils.disposeObject(_sceneNum);
               _sceneNum = null;
               if(_sceneId != 7 && _sceneId != 8)
               {
                  _sceneNum = ComponentFactory.Instance.creat("rescue.scene" + _sceneId);
                  PositionUtils.setPos(_sceneNum,"rescue.sceneNumPos");
                  addChild(_sceneNum);
               }
            }
            _info = param3;
            switch(int(_sceneId) - 7)
            {
               case 0:
                  _bg.setFrame(3);
                  break;
               case 1:
                  _bg.setFrame(4);
            }
            if(!_hBox)
            {
               _hBox = ComponentFactory.Instance.creatComponentByStylename("rescue.starHBox");
               addChild(_hBox);
            }
            _hBox.removeAllChild();
            _loc4_ = 1;
            while(_loc4_ <= _info.starCount)
            {
               _star = ComponentFactory.Instance.creat("rescue.star");
               _hBox.addChild(_star);
               _loc4_++;
            }
            _hBox.refreshChildPos();
         }
         else
         {
            _sceneId = param2;
            _bg.setFrame(2);
            ObjectUtils.disposeObject(_sceneNum);
            _sceneNum = null;
            ObjectUtils.disposeObject(_hBox);
            _hBox = null;
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         _light.visible = param1;
      }
      
      private function removeEvents() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_light);
         _light = null;
         ObjectUtils.disposeObject(_sceneNum);
         _sceneNum = null;
         ObjectUtils.disposeObject(_star);
         _star = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
      }
      
      public function get info() : RescueSceneInfo
      {
         return _info;
      }
      
      public function get sceneId() : int
      {
         return _sceneId;
      }
   }
}
