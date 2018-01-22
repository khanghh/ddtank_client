package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortion.ConsortionModelManager;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import quest.TaskManager;
   import trainer.view.NewHandContainer;
   
   public class BuildingManager extends Sprite implements Disposeable
   {
       
      
      private var _BG:MutipleImage;
      
      private var _bg:Bitmap;
      
      private var _tax:BaseButton;
      
      private var _establishment:BaseButton;
      
      private var _redPackage:BaseButton;
      
      private var _store:BaseButton;
      
      private var _boss:BaseButton;
      
      private var _chairmanChanel:TextButton;
      
      private var _manager:TextButton;
      
      private var _takeIn:TextButton;
      
      private var _exit:TextButton;
      
      private var _chairChannel:ChairmanChannelPanel;
      
      private var _chairChannelShow:Boolean = true;
      
      public function BuildingManager(){super();}
      
      private function initView() : void{}
      
      private function initRight() : void{}
      
      private function initEvent() : void{}
      
      private function guideHanlder() : void{}
      
      private function removeEvent() : void{}
      
      private function __propChange(param1:PlayerPropertyEvent) : void{}
      
      private function __onClickHandler(param1:MouseEvent) : void{}
      
      private function showChairmanChannel(param1:MouseEvent) : void{}
      
      private function __closeChairChnnel(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
