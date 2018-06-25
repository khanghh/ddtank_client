package cityBattle.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import cityBattle.CityBattleManager;
   import cityBattle.data.WelfareInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WelfareCell extends Sprite implements Disposeable
   {
       
      
      private var _exchangeBtn:SimpleBitmapButton;
      
      private var _bagCell:BagCell;
      
      private var _info:WelfareInfo;
      
      private var _lockIcon:Bitmap;
      
      private var open:Boolean = true;
      
      public function WelfareCell()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bagCell = new BagCell(0);
         addChild(_bagCell);
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("welfare.exchangebtn");
         addChild(_exchangeBtn);
         _exchangeBtn.visible = false;
         _lockIcon = ComponentFactory.Instance.creatBitmap("asset.cityBattle.lock");
         addChild(_lockIcon);
      }
      
      private function addEvent() : void
      {
         _exchangeBtn.addEventListener("click",__exchangeHandler);
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         _exchangeBtn.visible = false;
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         if(open)
         {
            _exchangeBtn.visible = true;
         }
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",__exchangeHandler);
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
      }
      
      private function __exchangeHandler(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuyFrame:QuickExchangeFrame = ComponentFactory.Instance.creatComponentByStylename("welfare.exchangeFrame");
         quickBuyFrame.setData(_info.TemplateID,_info.ID,_info.NeedScore);
         quickBuyFrame.type = _info.Quality;
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      public function set info(value:WelfareInfo) : void
      {
         _info = value;
         _bagCell.info = ItemManager.Instance.getTemplateById(_info.TemplateID);
         var _loc2_:int = 77;
         _bagCell.height = _loc2_;
         _bagCell.width = _loc2_;
         if(_info.Quality == 3)
         {
            if(CityBattleManager.instance.mySide == CityBattleManager.instance.winnerExchangeInfo[_info.Probability - 1])
            {
               open = true;
            }
            else
            {
               open = false;
            }
         }
         else
         {
            open = true;
         }
         _lockIcon.visible = !open;
      }
      
      public function get info() : WelfareInfo
      {
         return _info;
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
