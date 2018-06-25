package ddt.view.im
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import im.PresentRecordInfo;
   
   public class MessageBox extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _sign:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _cancelFlash:SimpleBitmapButton;
      
      private var _vbox:VBox;
      
      private var _item:Vector.<MessageBoxItem>;
      
      public var overState:Boolean;
      
      public function MessageBox()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("messageBox.bg");
         _sign = ComponentFactory.Instance.creatBitmap("asset.messagebox.sign");
         _title = ComponentFactory.Instance.creatComponentByStylename("messageBox.title");
         _cancelFlash = ComponentFactory.Instance.creatComponentByStylename("messageBox.cancelFlash");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("messagebox.vbox");
         addChild(_bg);
         addChild(_sign);
         addChild(_title);
         addChild(_cancelFlash);
         addChild(_vbox);
         _item = new Vector.<MessageBoxItem>();
         _title.text = LanguageMgr.GetTranslation("IM.messagebox.title");
         _cancelFlash.addEventListener("click",__cancelFlashHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         overState = false;
         IMManager.Instance.hideMessageBox();
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         overState = true;
      }
      
      protected function __cancelFlashHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IMManager.Instance.cancelFlash();
      }
      
      public function set message(message:Vector.<PresentRecordInfo>) : void
      {
         var i:int = 0;
         var item:* = null;
         clearBox();
         for(i = 0; i < message.length; )
         {
            item = new MessageBoxItem();
            item.recordInfo = message[i];
            item.addEventListener("click",__itemClickHandler);
            item.addEventListener("delete",__itemDeleteHandler);
            _vbox.addChild(item);
            _item.push(item);
            i++;
         }
         _bg.height = _item.length * 28 + 88;
      }
      
      private function clearBox() : void
      {
         var i:int = 0;
         for(i = 0; i < _item.length; )
         {
            if(_item[i])
            {
               _item[i].removeEventListener("click",__itemClickHandler);
               _item[i].removeEventListener("delete",__itemDeleteHandler);
               ObjectUtils.disposeObject(_item[i]);
            }
            _item[i] = null;
            i++;
         }
         _item = new Vector.<MessageBoxItem>();
      }
      
      protected function __itemDeleteHandler(event:Event) : void
      {
         var target:MessageBoxItem = event.currentTarget as MessageBoxItem;
         _item.splice(_item.indexOf(target),1);
         if(target)
         {
            target.removeEventListener("click",__itemClickHandler);
            target.removeEventListener("delete",__itemDeleteHandler);
            ObjectUtils.disposeObject(target);
         }
         target = null;
         IMManager.Instance.getMessage();
      }
      
      protected function __itemClickHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var target:MessageBoxItem = event.currentTarget as MessageBoxItem;
         if(target.recordInfo.teamId)
         {
            AssetModuleLoader.addModelLoader("team",7);
            AssetModuleLoader.startCodeLoader(showTeamChat);
         }
         else
         {
            IMManager.Instance.alertPrivateFrame(target.recordInfo.id);
         }
         IMManager.Instance.getMessage();
      }
      
      private function showTeamChat() : void
      {
         IMManager.Instance.alertTeamChatFrame(PlayerManager.Instance.Self.teamID);
      }
      
      public function dispose() : void
      {
         _cancelFlash.removeEventListener("click",__cancelFlashHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         clearBox();
         _item = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_sign)
         {
            ObjectUtils.disposeObject(_sign);
         }
         _sign = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_cancelFlash)
         {
            ObjectUtils.disposeObject(_cancelFlash);
         }
         _cancelFlash = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
