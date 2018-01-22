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
      
      public function initView(param1:int) : void
      {
         _ItemID = param1;
         if(param1 % 2 == 0)
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
         if(param1 <= 3)
         {
            _RankingText.visible = false;
            _RankingBitmp = ComponentFactory.Instance.creat("toffilist.guildMemberWeektopThreeRink");
            _RankingBitmp.setFrame(param1);
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
      
      private function __ItemWorkCheckKeyboard(param1:KeyboardEvent) : void
      {
         _ItemWork();
      }
      
      private function __ItemWorkFocusEvent(param1:FocusEvent) : void
      {
         _ItemWork();
      }
      
      private function _ItemWork() : void
      {
         var _loc2_:Number = NaN;
         if(_inputTxt.text == "")
         {
            _inputTxt.text = "0";
         }
         var _loc1_:Number = _inputTxt.text;
         var _loc6_:* = 0;
         var _loc4_:int = _ItemID - 1;
         var _loc5_:int = 0;
         var _loc3_:int = GuildMemberWeekManager.instance.model.PlayerAddPointBook.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(_loc5_ != _loc4_)
            {
               _loc6_ = Number(_loc6_ + GuildMemberWeekManager.instance.model.PlayerAddPointBook[_loc5_]);
            }
            _loc5_++;
         }
         if(_loc1_ < 0)
         {
            _loc1_ = PlayerManager.Instance.Self.Money - _loc6_;
         }
         else
         {
            _loc2_ = _loc6_ + _loc1_;
            if(_loc2_ >= PlayerManager.Instance.Self.Money)
            {
               _loc1_ = PlayerManager.Instance.Self.Money - _loc6_;
            }
         }
         _inputTxt.text = String(_loc1_);
         GuildMemberWeekManager.instance.Controller.upPointBookData(_ItemID,_loc1_);
      }
      
      public function ChangeGetPointBook(param1:int) : void
      {
         _ShowGetPointBookText.text = String(param1);
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
