package guildMemberWeek.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class AddRankingWorkItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _RankingBitmp:ScaleFrameImage;
      
      private var _RankingText:FilterFrameText;
      
      private var _AddPointBookText:FilterFrameText;
      
      private var _GetPointBookText:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _ShowGetPointBookText:FilterFrameText;
      
      private var _PointBookBitmp:Bitmap;
      
      private var _ItemID:int = 0;
      
      public function AddRankingWorkItem()
      {
         super();
      }
      
      public function get AddMoney() : int
      {
         return int(_inputTxt.text);
      }
      
      public function initView(Ranking:int) : void
      {
         _ItemID = Ranking;
         if(Ranking % 2 == 0)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.guildmemberweek.AddRankingFrame.ItemA");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.guildmemberweek.AddRankingFrame.ItemB");
         }
         _RankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.Item.RankingTxt");
         _AddPointBookText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.Item.AddPointBookTxt");
         _GetPointBookText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.Item.GetPointBookTxt");
         _ShowGetPointBookText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRankingFrame.Item.ShowGetPointBookTxt");
         _PointBookBitmp = ComponentFactory.Instance.creatBitmap("swf.guildmember.MainFrame.Left.Ranking.png");
         _PointBookBitmp.x = 327;
         _PointBookBitmp.y = 8;
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.addRanking.inputTxt");
         _inputTxt.tabEnabled = false;
         if(Ranking <= 3)
         {
            _RankingText.visible = false;
            _RankingBitmp = ComponentFactory.Instance.creat("toffilist.guildMemberWeektopThreeRink");
            _RankingBitmp.setFrame(Ranking);
            _RankingBitmp.y = 4;
            _RankingBitmp.x = -4;
         }
         else
         {
            _RankingText.visible = true;
         }
         addChild(_bg);
         addChild(_RankingText);
         if(_RankingBitmp)
         {
            addChild(_RankingBitmp);
         }
         addChild(_AddPointBookText);
         addChild(_GetPointBookText);
         addChild(_ShowGetPointBookText);
         addChild(_PointBookBitmp);
         addChild(_inputTxt);
         initText();
         initEvent();
      }
      
      public function initText() : void
      {
         _AddPointBookText.text = LanguageMgr.GetTranslation("money");
         _GetPointBookText.text = LanguageMgr.GetTranslation("money");
         _RankingText.text = _ItemID + "th";
         _ShowGetPointBookText.text = "0";
         _inputTxt.text = "0";
      }
      
      public function initEvent() : void
      {
         addEventListener("keyUp",__ItemWorkCheckKeyboard);
         addEventListener("focusOut",__ItemWorkFocusEvent);
      }
      
      private function RemoveEvent() : void
      {
         removeEventListener("keyUp",__ItemWorkCheckKeyboard);
         removeEventListener("focusOut",__ItemWorkFocusEvent);
      }
      
      private function __ItemWorkCheckKeyboard(event:KeyboardEvent) : void
      {
         _ItemWork();
      }
      
      private function __ItemWorkFocusEvent(event:FocusEvent) : void
      {
         _ItemWork();
      }
      
      private function _ItemWork() : void
      {
         var tempAllMoney:Number = NaN;
         if(_inputTxt.text == "")
         {
            _inputTxt.text = "0";
         }
         var Money:Number = _inputTxt.text;
         var AllMoney:* = 0;
         var N:int = _ItemID - 1;
         var i:int = 0;
         var L:int = GuildMemberWeekManager.instance.model.PlayerAddPointBook.length;
         for(i = 0; i < L; )
         {
            if(i != N)
            {
               AllMoney = Number(AllMoney + GuildMemberWeekManager.instance.model.PlayerAddPointBook[i]);
            }
            i++;
         }
         if(Money < 0)
         {
            Money = PlayerManager.Instance.Self.Money - AllMoney;
         }
         else
         {
            tempAllMoney = AllMoney + Money;
            if(tempAllMoney >= PlayerManager.Instance.Self.Money)
            {
               Money = PlayerManager.Instance.Self.Money - AllMoney;
            }
         }
         _inputTxt.text = String(Money);
         GuildMemberWeekManager.instance.Controller.upPointBookData(_ItemID,Money);
      }
      
      public function ChangeGetPointBook(Money:int) : void
      {
         _ShowGetPointBookText.text = String(Money);
      }
      
      public function dispose() : void
      {
         RemoveEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_RankingText);
         _RankingText = null;
         if(_RankingBitmp)
         {
            ObjectUtils.disposeObject(_RankingBitmp);
         }
         _RankingBitmp = null;
         ObjectUtils.disposeObject(_AddPointBookText);
         _AddPointBookText = null;
         ObjectUtils.disposeObject(_GetPointBookText);
         _GetPointBookText = null;
         ObjectUtils.disposeObject(_ShowGetPointBookText);
         _ShowGetPointBookText = null;
         ObjectUtils.disposeObject(_PointBookBitmp);
         _PointBookBitmp = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
