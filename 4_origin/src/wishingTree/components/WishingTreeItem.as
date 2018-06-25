package wishingTree.components
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WishingTreeItem extends Sprite implements Disposeable
   {
       
      
      private var _label:FilterFrameText;
      
      private var _cell:BaseCell;
      
      private var _btn:SimpleBitmapButton;
      
      private var _alreadyGet:Bitmap;
      
      private var _index:int;
      
      private var _num:int;
      
      private var _rewardId:int;
      
      public function WishingTreeItem(index:int, num:int, rewardId:int)
      {
         super();
         _index = index;
         _num = num;
         _rewardId = rewardId;
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _label = ComponentFactory.Instance.creatComponentByStylename("wishingTree.label");
         addChild(_label);
         _label.text = LanguageMgr.GetTranslation("wishingTree.labelTxt",_num);
         _btn = ComponentFactory.Instance.creatComponentByStylename("wishingTree.getBtn");
         addChild(_btn);
         _alreadyGet = ComponentFactory.Instance.creat("wishingTree.alreadyGet");
         addChild(_alreadyGet);
         _alreadyGet.visible = false;
         var cellBg:Sprite = new Sprite();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,30,30);
         cellBg.graphics.endFill();
         _cell = new BaseCell(cellBg,ItemManager.Instance.getTemplateById(_rewardId));
         PositionUtils.setPos(_cell,"wishingTree.cellPos");
         addChild(_cell);
      }
      
      private function addEvents() : void
      {
         _btn.addEventListener("click",__btnClick);
      }
      
      protected function __btnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.wishingTreeGetReward(_index);
      }
      
      public function setState(times:int, state:int) : void
      {
         var isGain:* = state >> _index & 1;
         if(times >= _num)
         {
            if(isGain)
            {
               _alreadyGet.visible = true;
               _btn.visible = false;
            }
            else
            {
               _alreadyGet.visible = false;
               _btn.visible = true;
               _btn.enable = true;
            }
         }
         else
         {
            _alreadyGet.visible = false;
            _btn.visible = true;
            _btn.enable = false;
         }
      }
      
      private function removeEvents() : void
      {
         _btn.removeEventListener("click",__btnClick);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_label);
         _label = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_alreadyGet);
         _alreadyGet = null;
      }
   }
}
