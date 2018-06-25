package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListInfo;
   
   public class GodCardRaiseAtlasView extends Sprite implements Disposeable
   {
       
      
      private var _bg:MutipleImage;
      
      private var _selectGroup:SelectedButtonGroup;
      
      private var _whiteCardBtn:SelectedButton;
      
      private var _greenCardBtn:SelectedButton;
      
      private var _blueCardBtn:SelectedButton;
      
      private var _purpleCardBtn:SelectedButton;
      
      private var _goldCardBtn:SelectedButton;
      
      private var _whiteCards:Sprite;
      
      private var _greenCards:Sprite;
      
      private var _blueCards:Sprite;
      
      private var _purpleCards:Sprite;
      
      private var _goldCards:Sprite;
      
      private var _currentCards:Sprite;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _myClipTxt:FilterFrameText;
      
      public function GodCardRaiseAtlasView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.bg");
         addChild(_bg);
         _myClipTxt = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.myClipTxt");
         _myClipTxt.text = GodCardRaiseManager.Instance.model.chipCount + "";
         addChild(_myClipTxt);
         _whiteCardBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.whiteCardBtn");
         addChild(_whiteCardBtn);
         _greenCardBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.greenCardBtn");
         addChild(_greenCardBtn);
         _blueCardBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.blueCardBtn");
         addChild(_blueCardBtn);
         _purpleCardBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.purpleCardBtn");
         addChild(_purpleCardBtn);
         _goldCardBtn = ComponentFactory.Instance.creatComponentByStylename("godCardRaiseAtlasView.goldCardBtn");
         addChild(_goldCardBtn);
         _selectGroup = new SelectedButtonGroup();
         _selectGroup.addSelectItem(_whiteCardBtn);
         _selectGroup.addSelectItem(_greenCardBtn);
         _selectGroup.addSelectItem(_blueCardBtn);
         _selectGroup.addSelectItem(_purpleCardBtn);
         _selectGroup.addSelectItem(_goldCardBtn);
         _selectGroup.selectIndex = 0;
         _scrollPanel = ComponentFactory.Instance.creat("godCardRaiseAtlasView.scrollPanel");
         addChild(_scrollPanel);
         getView();
      }
      
      private function __selectGroupHandler(event:Event) : void
      {
         SoundManager.instance.playButtonSound();
         getView();
      }
      
      private function getView() : void
      {
         if(_whiteCards)
         {
            _whiteCards.visible = false;
         }
         if(_greenCards)
         {
            _greenCards.visible = false;
         }
         if(_blueCards)
         {
            _blueCards.visible = false;
         }
         if(_purpleCards)
         {
            _purpleCards.visible = false;
         }
         if(_goldCards)
         {
            _goldCards.visible = false;
         }
         if(_selectGroup.selectIndex == 1)
         {
            if(_greenCards)
            {
               _greenCards.visible = true;
            }
            else
            {
               _greenCards = new Sprite();
               addChild(_greenCards);
               addGodCardRaiseAtlasCards(_greenCards,1);
            }
            _scrollPanel.setView(_greenCards);
            _currentCards = _greenCards;
         }
         else if(_selectGroup.selectIndex == 2)
         {
            if(_blueCards)
            {
               _blueCards.visible = true;
            }
            else
            {
               _blueCards = new Sprite();
               addChild(_blueCards);
               addGodCardRaiseAtlasCards(_blueCards,2);
            }
            _scrollPanel.setView(_blueCards);
            _currentCards = _blueCards;
         }
         else if(_selectGroup.selectIndex == 3)
         {
            if(_purpleCards)
            {
               _purpleCards.visible = true;
            }
            else
            {
               _purpleCards = new Sprite();
               addChild(_purpleCards);
               addGodCardRaiseAtlasCards(_purpleCards,3);
            }
            _scrollPanel.setView(_purpleCards);
            _currentCards = _purpleCards;
         }
         else if(_selectGroup.selectIndex == 4)
         {
            if(_goldCards)
            {
               _goldCards.visible = true;
            }
            else
            {
               _goldCards = new Sprite();
               addChild(_goldCards);
               addGodCardRaiseAtlasCards(_goldCards,4);
            }
            _scrollPanel.setView(_goldCards);
            _currentCards = _goldCards;
         }
         else
         {
            if(_whiteCards)
            {
               _whiteCards.visible = true;
            }
            else
            {
               _whiteCards = new Sprite();
               addChild(_whiteCards);
               addGodCardRaiseAtlasCards(_whiteCards,0);
            }
            _scrollPanel.setView(_whiteCards);
            _currentCards = _whiteCards;
         }
         _scrollPanel.invalidateViewport();
         if(_currentCards)
         {
            updateCards(_currentCards);
         }
      }
      
      private function addGodCardRaiseAtlasCards($cards:Sprite, $level:int) : void
      {
         var i:int = 0;
         var godCardInfo:* = null;
         var godAtlasCard:* = null;
         var arr:Array = GodCardRaiseManager.Instance.getGodCardListInfoListByLevel($level);
         if(arr)
         {
            for(i = 0; i < arr.length; )
            {
               godCardInfo = arr[i] as GodCardListInfo;
               godAtlasCard = new GodCardRaiseAtlasCard();
               godAtlasCard.info = godCardInfo;
               godAtlasCard.x = i % 4 * 166;
               godAtlasCard.y = int(i / 4) * 260;
               $cards.addChild(godAtlasCard);
               i++;
            }
         }
      }
      
      public function updateView() : void
      {
         if(_myClipTxt)
         {
            _myClipTxt.text = GodCardRaiseManager.Instance.model.chipCount + "";
         }
         if(_currentCards)
         {
            updateCards(_currentCards);
         }
      }
      
      private function updateCards($sp:Sprite) : void
      {
         var i:int = 0;
         var godAtlasCard:* = null;
         for(i = 0; i < $sp.numChildren; )
         {
            godAtlasCard = $sp.getChildAt(i) as GodCardRaiseAtlasCard;
            godAtlasCard.updateView();
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _selectGroup.addEventListener("change",__selectGroupHandler);
      }
      
      private function removeEvent() : void
      {
         _selectGroup.removeEventListener("change",__selectGroupHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(_whiteCards);
         ObjectUtils.disposeAllChildren(_greenCards);
         ObjectUtils.disposeAllChildren(_blueCards);
         ObjectUtils.disposeAllChildren(_purpleCards);
         ObjectUtils.disposeAllChildren(_goldCards);
         ObjectUtils.disposeAllChildren(this);
         _whiteCards = null;
         _greenCards = null;
         _blueCards = null;
         _purpleCards = null;
         _goldCards = null;
         _whiteCardBtn = null;
         _greenCardBtn = null;
         _blueCardBtn = null;
         _purpleCardBtn = null;
         _goldCardBtn = null;
         _selectGroup = null;
         _scrollPanel = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
