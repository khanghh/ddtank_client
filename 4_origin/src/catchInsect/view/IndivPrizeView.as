package catchInsect.view
{
   import catchInsect.componets.IndivPrizeCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ServerConfigManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class IndivPrizeView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _listItem:Vector.<IndivPrizeCell>;
      
      public function IndivPrizeView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var arr:* = null;
         var cell:* = null;
         _bg = ComponentFactory.Instance.creat("catchInsect.indivPrizeBg");
         addChild(_bg);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrize.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("catchInsect.indivPrize.scrollpanel");
         _scrollPanel.setView(_vbox);
         addChild(_scrollPanel);
         _listItem = new Vector.<IndivPrizeCell>();
         var prizeArr:Array = ServerConfigManager.instance.catchInsectPrizeInfo;
         for(i = 0; i <= prizeArr.length - 1; )
         {
            arr = prizeArr[i].split(",");
            cell = new IndivPrizeCell();
            cell.setData(arr[0],arr[1]);
            _vbox.addChild(cell);
            _listItem.push(cell);
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function initEvents() : void
      {
      }
      
      public function setPrizeStatus(status:int) : void
      {
         var i:int = 0;
         for(i = 0; i <= _listItem.length - 1; )
         {
            _listItem[i].setStatus(status & 1);
            status = status >> 1;
            i++;
         }
      }
      
      private function removeEvents() : void
      {
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvents();
         for(i = 0; i <= _listItem.length - 1; )
         {
            ObjectUtils.disposeObject(_listItem[i]);
            _listItem[i] = null;
            i++;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
      }
   }
}
