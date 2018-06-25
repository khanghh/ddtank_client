package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import ringStation.model.BattleFieldListItemInfo;
   import road7th.comm.PackageIn;
   
   public class BattleFieldsView extends Frame
   {
      
      private static const BATTLEFILEDSNUM:int = 11;
       
      
      private var _bg:MutipleImage;
      
      private var _itemVec:Vector.<BattleFieldsItem>;
      
      public function BattleFieldsView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ringStation.view.battleFieldsView.titleInfo");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.battleField.bg");
         addToContent(_bg);
         initItemData();
         sendPkg();
      }
      
      private function initItemData() : void
      {
         var i:int = 0;
         var infoItem:* = null;
         _itemVec = new Vector.<BattleFieldsItem>();
         var pos:Point = PositionUtils.creatPoint("ringStation.view.battleField.itemPos");
         for(i = 0; i < 11; )
         {
            infoItem = new BattleFieldsItem(i);
            infoItem.x = pos.x;
            infoItem.y = pos.y + i * 34;
            addToContent(infoItem);
            _itemVec.push(infoItem);
            i++;
         }
      }
      
      private function sendPkg() : void
      {
         SocketManager.Instance.out.sendRingStationBattleField();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(404,4),__onUpdateNewBattleField);
      }
      
      protected function __onUpdateNewBattleField(event:PkgEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         var info:BattleFieldListItemInfo = new BattleFieldListItemInfo();
         var count:int = pkg.readInt();
         var newString:String = "";
         for(i = 0; i < count; )
         {
            info.DareFlag = pkg.readBoolean();
            info.UserName = pkg.readUTF();
            info.SuccessFlag = pkg.readBoolean();
            info.Level = pkg.readInt();
            _itemVec[i].update(info);
            i++;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(404,4),__onUpdateNewBattleField);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         for(i = 0; i < _itemVec.length; )
         {
            if(_itemVec[i])
            {
               ObjectUtils.disposeObject(_itemVec[i]);
               _itemVec[i] = null;
            }
            i++;
         }
         _itemVec.length = 0;
         _itemVec = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
