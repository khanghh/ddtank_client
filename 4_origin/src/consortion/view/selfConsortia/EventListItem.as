package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.ConsortiaEventInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class EventListItem extends Sprite implements Disposeable
   {
       
      
      private var _backGroud:Bitmap;
      
      private var _eventType:ScaleFrameImage;
      
      private var _content:FilterFrameText;
      
      public function EventListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _backGroud = ComponentFactory.Instance.creatBitmap("asset.eventItem.BG");
         _eventType = ComponentFactory.Instance.creatComponentByStylename("eventItem.type");
         _content = ComponentFactory.Instance.creatComponentByStylename("eventItem.content");
         addChild(_backGroud);
         addChild(_eventType);
         addChild(_content);
      }
      
      public function set info(param1:ConsortiaEventInfo) : void
      {
         var _loc2_:String = param1.Date.toString().split(" ")[0];
         switch(int(param1.Type) - 5)
         {
            case 0:
               _eventType.setFrame(1);
               if(param1.NickName.toLowerCase() == "gm")
               {
                  _content.text = LanguageMgr.GetTranslation("ddt.consortia.event.contributeGM",_loc2_,param1.EventValue);
               }
               else
               {
                  _content.text = LanguageMgr.GetTranslation("ddt.consortia.event.contribute",_loc2_,param1.NickName,param1.EventValue);
               }
               break;
            case 1:
               _eventType.setFrame(2);
               _content.text = LanguageMgr.GetTranslation("ddt.consortia.event.join",_loc2_,param1.ManagerName,param1.NickName);
               break;
            case 2:
               _eventType.setFrame(3);
               _content.text = LanguageMgr.GetTranslation("ddt.consortia.event.quite",_loc2_,param1.ManagerName,param1.NickName);
               break;
            case 3:
               _eventType.setFrame(4);
               _content.text = LanguageMgr.GetTranslation("ddt.consortia.event.quit",_loc2_,param1.NickName);
               break;
            case 4:
               _eventType.setFrame(5);
               _content.text = LanguageMgr.GetTranslation("ddt.consortia.event.skill",_loc2_,param1.NickName,param1.ManagerName);
         }
         _content.y = _backGroud.height / 2 - _content.textHeight / 2;
      }
      
      override public function get height() : Number
      {
         return _backGroud.height;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _backGroud = null;
         _eventType = null;
         _content = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
