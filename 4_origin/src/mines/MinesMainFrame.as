package mines
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import labyrinth.LabyrinthManager;
   import mines.mornui.MinesMainFrameUI;
   import mines.view.DigView;
   import mines.view.EquipmentView;
   import mines.view.MinesBagView;
   import mines.view.ShopView;
   import mines.view.ToolView;
   import morn.core.handlers.Handler;
   
   public class MinesMainFrame extends MinesMainFrameUI
   {
       
      
      private var _bagView:MinesBagView;
      
      private var _digView:DigView;
      
      private var _shopView:ShopView;
      
      private var _toolView:ToolView;
      
      private var _equipmentView:EquipmentView;
      
      private var _index:int;
      
      public function MinesMainFrame()
      {
         super();
         addEvent();
      }
      
      private function addEvent() : void
      {
         MinesManager.instance.addEventListener(MinesManager.UPDATA_SHOP,openShopView);
         tabMain.selectHandler = new Handler(select);
         closeBtn.clickHandler = new Handler(dispose);
         helpBtn.clickHandler = new Handler(openHelp);
         chatBtn.clickHandler = new Handler(chatHandler);
         chatBtn.tipData = LanguageMgr.GetTranslation("tank.game.ToolStripView.chat");
         tabMain.selectedIndex = 0;
         _bagView.addEventListener("doubleclick",doubleClick);
      }
      
      private function chatHandler() : void
      {
         SoundManager.instance.playButtonSound();
         LabyrinthManager.Instance.chat();
      }
      
      private function select(index:int) : void
      {
         _index = index;
         switch(int(_index))
         {
            case 0:
               if(_digView)
               {
                  _digView.visible = true;
                  mainBox.swapChildrenAt(mainBox.getChildIndex(_digView),0);
               }
               else
               {
                  _digView = ClassUtils.CreatInstance("mines.view.DigView");
                  mainBox.addChildAt(_digView,0);
               }
               if(_shopView)
               {
                  _shopView.visible = false;
               }
               if(_toolView)
               {
                  _toolView.visible = false;
               }
               if(_equipmentView)
               {
                  _equipmentView.visible = false;
               }
               break;
            case 1:
               SocketManager.Instance.out.sendMinesShopHandler();
               break;
            case 2:
               if(_toolView)
               {
                  _toolView.cellChange(null);
                  _toolView.visible = true;
                  mainBox.swapChildrenAt(mainBox.getChildIndex(_toolView),0);
               }
               else
               {
                  _toolView = ClassUtils.CreatInstance("mines.view.ToolView");
                  mainBox.addChildAt(_toolView,0);
               }
               if(_digView)
               {
                  _digView.visible = false;
                  _digView.stopDig();
               }
               if(_shopView)
               {
                  _shopView.visible = false;
               }
               if(_equipmentView)
               {
                  _equipmentView.visible = false;
               }
               break;
            case 3:
               if(_equipmentView)
               {
                  _equipmentView.cellChange(null);
                  _equipmentView.visible = true;
                  mainBox.swapChildrenAt(mainBox.getChildIndex(_equipmentView),0);
               }
               else
               {
                  _equipmentView = ClassUtils.CreatInstance("mines.view.EquipmentView");
                  mainBox.addChildAt(_equipmentView,0);
               }
               if(_digView)
               {
                  _digView.visible = false;
                  _digView.stopDig();
               }
               if(_shopView)
               {
                  _shopView.visible = false;
               }
               if(_toolView)
               {
                  _toolView.visible = false;
                  break;
               }
         }
      }
      
      private function openShopView(e:Event) : void
      {
         if(!MinesManager.instance.viewOpen)
         {
            if(_shopView)
            {
               _shopView.updataList();
            }
            return;
         }
         if(_shopView)
         {
            _shopView.updataList();
            _shopView.visible = true;
            mainBox.swapChildrenAt(mainBox.getChildIndex(_shopView),0);
         }
         else
         {
            _shopView = ClassUtils.CreatInstance("mines.view.ShopView");
            mainBox.addChildAt(_shopView,0);
         }
         if(_digView)
         {
            _digView.visible = false;
            _digView.stopDig();
         }
         if(_toolView)
         {
            _toolView.visible = false;
         }
         if(_equipmentView)
         {
            _equipmentView.visible = false;
         }
      }
      
      override protected function initialize() : void
      {
         _bagView = ClassUtils.CreatInstance("mines.view.MinesBagView");
         _bagView.setData(PlayerManager.Instance.Self.getBag(52));
         mainBox.addChild(_bagView);
         PositionUtils.setPos(_bagView,"mines.mainFrame.bagViewPos");
      }
      
      private function doubleClick(e:CellEvent) : void
      {
         if(_toolView && _toolView.visible)
         {
            if(e.data)
            {
               _toolView.cellChange(e.data as BagCell);
            }
            else
            {
               _toolView.cellChange(null);
            }
         }
         if(_equipmentView && _equipmentView.visible)
         {
            if(e.data)
            {
               _equipmentView.cellChange(e.data as BagCell);
            }
            else
            {
               _equipmentView.cellChange(null);
            }
         }
      }
      
      private function openHelp() : void
      {
         var frame:* = ClassUtils.CreatInstance("mines.view.HelpFrame");
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function removeEvent() : void
      {
         MinesManager.instance.removeEventListener(MinesManager.UPDATA_SHOP,openShopView);
         _bagView.removeEventListener("doubleclick",doubleClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_digView)
         {
            _digView.dispose();
         }
         if(_shopView)
         {
            _shopView.dispose();
         }
         if(_toolView)
         {
            _toolView.dispose();
         }
         if(_equipmentView)
         {
            _equipmentView.dispose();
         }
         super.dispose();
      }
   }
}
