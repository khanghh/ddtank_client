package Indiana.item
{
   import Indiana.model.IndianaData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   
   public class IndianaRecodeItem extends Sprite implements Disposeable
   {
       
      
      private var _timeTxt:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _severName:FilterFrameText;
      
      private var _timers:FilterFrameText;
      
      private var _lookMa:FilterFrameText;
      
      private var _info:IndianaData;
      
      public function IndianaRecodeItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         PositionUtils.setPos(_timeTxt,"indiana.recodetime.pos");
         _name = ComponentFactory.Instance.creatComponentByStylename("indiana.name.Txt");
         PositionUtils.setPos(_name,"indiana.recodename.pos");
         _severName = ComponentFactory.Instance.creatComponentByStylename("indiana.name.Txt");
         PositionUtils.setPos(_severName,"indiana.recodesever.pos");
         _timers = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         PositionUtils.setPos(_timers,"indiana.recodetimeNum.pos");
         _lookMa = ComponentFactory.Instance.creatComponentByStylename("indiana.attribute.Txt");
         _lookMa.mouseEnabled = true;
         PositionUtils.setPos(_lookMa,"indiana.recodeCheck.pos");
         addChild(_timeTxt);
         addChild(_name);
         addChild(_severName);
         addChild(_timers);
         addChild(_lookMa);
      }
      
      private function initEvent() : void
      {
         _lookMa.addEventListener("link",__linkHandler);
      }
      
      private function removeEvent() : void
      {
         _lookMa.removeEventListener("link",__linkHandler);
      }
      
      private function __linkHandler(e:TextEvent) : void
      {
         var id:int = 0;
         var cmdArray:Array = e.text.split("|");
         if(cmdArray[0] == "clickother")
         {
            id = cmdArray[1];
            SocketManager.Instance.out.sendIndianaCode(id,_info.useId);
         }
      }
      
      public function set info(value:IndianaData) : void
      {
         _info = value;
         if(_info)
         {
            _timeTxt.text = _info.joinTime;
            _name.text = _info.nickName;
            _severName.text = _info.areaName;
            _timers.text = _info.joinCount.toString();
            _lookMa.htmlText = LanguageMgr.GetTranslation("Indiana.recode.checkNum",_info.per_Id);
            _lookMa.x = _timers.textWidth + _timers.x + 3;
         }
      }
      
      override public function get height() : Number
      {
         return 17;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _timeTxt = null;
         _name = null;
         _severName = null;
         _timers = null;
         _lookMa = null;
      }
   }
}
