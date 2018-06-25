package collectionTask.view
{
   import collectionTask.model.CollectionTaskModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CollectionTaskMenuView extends Sprite implements Disposeable
   {
       
      
      private var _menuShowName:ScaleFrameImage;
      
      private var _menuShowPao:ScaleFrameImage;
      
      private var _menuShowPlayer:ScaleFrameImage;
      
      private var _model:CollectionTaskModel;
      
      public function CollectionTaskMenuView(model:CollectionTaskModel)
      {
         super();
         _model = model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _menuShowName = ComponentFactory.Instance.creatComponentByStylename("collectionTask.menuShowNameAsset");
         _menuShowName.buttonMode = true;
         _menuShowName.setFrame(1);
         addChild(_menuShowName);
         _menuShowPao = ComponentFactory.Instance.creatComponentByStylename("collectionTask.menuShowPaoAsset");
         _menuShowPao.buttonMode = true;
         _menuShowPao.setFrame(1);
         addChild(_menuShowPao);
         _menuShowPlayer = ComponentFactory.Instance.creatComponentByStylename("collectionTask.menuShowPlayerAsset");
         _menuShowPlayer.buttonMode = true;
         _menuShowPlayer.setFrame(1);
         addChild(_menuShowPlayer);
      }
      
      private function addEvent() : void
      {
         _menuShowName.addEventListener("click",onMenuClick);
         _menuShowPao.addEventListener("click",onMenuClick);
         _menuShowPlayer.addEventListener("click",onMenuClick);
      }
      
      private function onMenuClick(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = evt.currentTarget;
         if(_menuShowName !== _loc2_)
         {
            if(_menuShowPao !== _loc2_)
            {
               if(_menuShowPlayer === _loc2_)
               {
                  if(_menuShowPlayer.getFrame == 1)
                  {
                     _menuShowPlayer.setFrame(2);
                     _model.playerVisible = false;
                  }
                  else
                  {
                     _menuShowPlayer.setFrame(1);
                     _model.playerVisible = true;
                  }
               }
            }
            else if(_menuShowPao.getFrame == 1)
            {
               _menuShowPao.setFrame(2);
               _model.playerChatBallVisible = false;
            }
            else
            {
               _menuShowPao.setFrame(1);
               _model.playerChatBallVisible = true;
            }
         }
         else if(_menuShowName.getFrame == 1)
         {
            _menuShowName.setFrame(2);
            _model.playerNameVisible = false;
         }
         else
         {
            _menuShowName.setFrame(1);
            _model.playerNameVisible = true;
         }
      }
      
      private function removeEvent() : void
      {
         _menuShowName.removeEventListener("click",onMenuClick);
         _menuShowPao.removeEventListener("click",onMenuClick);
         _menuShowPlayer.removeEventListener("click",onMenuClick);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_menuShowName);
         _menuShowName = null;
         ObjectUtils.disposeObject(_menuShowPao);
         _menuShowPao = null;
         ObjectUtils.disposeObject(_menuShowPlayer);
         _menuShowPlayer = null;
      }
   }
}
