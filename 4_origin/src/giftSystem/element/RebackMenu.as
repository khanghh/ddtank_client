package giftSystem.element
{
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.data.RecordItemInfo;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import giftSystem.GiftManager;
   
   public class RebackMenu extends Sprite
   {
      
      private static var _instance:RebackMenu;
       
      
      private var _BG:Bitmap;
      
      private var _rebackBtn:BaseButton;
      
      private var _checkBtn:BaseButton;
      
      private var _info:RecordItemInfo;
      
      public function RebackMenu()
      {
         super();
         initView();
         initEvent();
      }
      
      public static function get Instance() : RebackMenu
      {
         if(_instance == null)
         {
            _instance = new RebackMenu();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         _BG = ComponentFactory.Instance.creatBitmap("bagAndInfo.cellMenu.CellMenuBGAsset");
         _rebackBtn = ComponentFactory.Instance.creatComponentByStylename("RebackMenu.rebackBtn");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("RebackMenu.checkBtn");
         graphics.beginFill(0,0);
         graphics.drawRect(-3000,-3000,6000,6000);
         graphics.endFill();
         addChild(_BG);
         addChild(_rebackBtn);
         addChild(_checkBtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__mouseClick);
         _rebackBtn.addEventListener("click",__reback);
         _checkBtn.addEventListener("click",__check);
      }
      
      private function __mouseClick(evt:MouseEvent) : void
      {
         hide();
         SoundManager.instance.play("008");
      }
      
      private function __check(event:MouseEvent) : void
      {
         PlayerInfoViewControl.viewByID(_info.playerID);
      }
      
      private function __reback(event:MouseEvent) : void
      {
      }
      
      public function show(info:RecordItemInfo, x:int, y:int) : void
      {
         if(_info != info)
         {
            _info = info;
         }
         LayerManager.Instance.addToLayer(this,2);
         this.x = x;
         this.y = y;
      }
      
      public function hide() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
