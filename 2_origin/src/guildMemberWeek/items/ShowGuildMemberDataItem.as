package guildMemberWeek.items
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import guildMemberWeek.manager.GuildMemberWeekManager;
   
   public class ShowGuildMemberDataItem extends Sprite implements Disposeable
   {
       
      
      private var _RankingBitmp:ScaleFrameImage;
      
      private var _RankingText:FilterFrameText;
      
      private var _MemberNameText:FilterFrameText;
      
      private var _MemberContributeText:FilterFrameText;
      
      private var _AddRankingText:FilterFrameText;
      
      private var _AddRankingBtn:BaseButton;
      
      private var _AddRankingSprite:Sprite;
      
      private var _AddRankingBg:Bitmap;
      
      private var _itemCells:Array;
      
      public var Count:int = 1;
      
      private var _templateInfo:ItemTemplateInfo;
      
      public function ShowGuildMemberDataItem()
      {
         super();
      }
      
      public function GetTemplateInfo(param1:int) : ItemTemplateInfo
      {
         return ItemManager.Instance.getTemplateById(param1);
      }
      
      public function initView(param1:int) : void
      {
         _RankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrame.left.ShowGuildMemberDataItem.RankingTxt");
         _RankingText.text = param1 + "th";
         _MemberNameText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrame.left.ShowGuildMemberDataItem.MemberNameTxt");
         _MemberContributeText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrame.left.ShowGuildMemberDataItem.MemberContributeTxt");
         _AddRankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrame.left.ShowGuildMemberDataItem.AddRankingTxt");
         _AddRankingBg = ComponentFactory.Instance.creatBitmap("swf.guildmember.MainFrame.Left.Ranking.png");
         _AddRankingSprite = new Sprite();
         _AddRankingSprite.addChild(_AddRankingBg);
         _AddRankingSprite.addChild(_AddRankingText);
         _AddRankingBtn = GuildMemberWeekManager.instance.returnComponentBnt(_AddRankingSprite);
         _AddRankingBtn.y = 5;
         _AddRankingBtn.x = 465;
         _AddRankingBtn.buttonMode = false;
         if(param1 <= 3)
         {
            _RankingText.visible = false;
            _RankingBitmp = ComponentFactory.Instance.creat("toffilist.guildMemberWeektopThreeRink");
            _RankingBitmp.setFrame(param1);
         }
         else
         {
            _RankingText.visible = true;
         }
         addChild(_RankingText);
         addChild(_MemberNameText);
         addChild(_MemberContributeText);
         addChild(_AddRankingBtn);
         addChild(_AddRankingSprite);
         if(_RankingBitmp)
         {
            addChild(_RankingBitmp);
         }
      }
      
      protected function creatItemCell() : BaseCell
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,30,30);
         _loc1_.graphics.endFill();
         var _loc2_:BaseCell = new BaseCell(_loc1_,null,true,true);
         _loc2_.tipDirctions = "7,6,2,1,5,4,0,3,6";
         _loc2_.tipGapV = 10;
         _loc2_.tipGapH = 10;
         _loc2_.tipStyle = "core.GoodsTip";
         return _loc2_;
      }
      
      public function initMember(param1:String, param2:String) : void
      {
         _MemberNameText.text = param1;
         _MemberContributeText.text = param2;
      }
      
      public function initAddPointBook(param1:int) : void
      {
         _AddRankingText.text = String(param1);
         _AddRankingBtn.tipData = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.CanGetPointBook") + _AddRankingText.text;
         _AddRankingBtn.tipGapH = 520;
      }
      
      public function initItemCell(param1:String) : void
      {
         var _loc9_:* = null;
         var _loc5_:* = null;
         _itemCells = [];
         var _loc4_:Array = param1.split(",");
         var _loc10_:int = 0;
         var _loc7_:int = _loc4_.length;
         var _loc8_:Point = PositionUtils.creatPoint("guildMemberWeek.ShowGift.cellPos");
         var _loc3_:int = _loc8_.x;
         var _loc2_:int = _loc8_.y;
         var _loc6_:int = 0;
         _loc10_ = 0;
         while(_loc10_ < _loc7_)
         {
            _loc9_ = creatItemCell();
            _loc9_.buttonMode = true;
            _loc9_.width = 30;
            _loc9_.height = 30;
            _loc9_.info = GetTemplateInfo(int(_loc4_[_loc10_]));
            _loc9_.buttonMode = true;
            _loc9_.x = _loc3_ + _loc6_ * 35;
            _loc9_.y = _loc2_;
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.left.giftNumberShowTxt");
            _loc5_.text = "";
            if(_loc4_[_loc10_ + 1] != undefined)
            {
               _loc5_.text = _loc4_[_loc10_ + 1];
            }
            _loc9_.addChild(_loc5_);
            _itemCells.push([_loc9_,_loc5_,int(_loc4_[_loc10_ + 1])]);
            addChild(_loc9_);
            _loc6_++;
            _loc10_ = _loc10_ + 2;
         }
      }
      
      private function disposeItemCell() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_itemCells)
         {
            _loc1_ = _itemCells.length;
            _loc2_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               ObjectUtils.disposeObject(_itemCells[_loc2_][1]);
               ObjectUtils.disposeObject(_itemCells[_loc2_][0]);
               _itemCells[_loc2_][0] = null;
               _itemCells[_loc2_][1] = null;
               _itemCells[_loc2_][2] = null;
               _itemCells[_loc2_] = null;
               _loc2_++;
            }
            _itemCells = null;
         }
      }
      
      public function dispose() : void
      {
         disposeItemCell();
         ObjectUtils.disposeObject(_RankingText);
         _RankingText = null;
         ObjectUtils.disposeObject(_MemberNameText);
         _MemberNameText = null;
         ObjectUtils.disposeObject(_MemberContributeText);
         _MemberContributeText = null;
         ObjectUtils.disposeAllChildren(_AddRankingBtn);
         ObjectUtils.disposeObject(_AddRankingBtn);
         _AddRankingBtn = null;
         if(_RankingBitmp)
         {
            ObjectUtils.disposeObject(_RankingBitmp);
         }
         _RankingBitmp = null;
         if(_AddRankingSprite)
         {
            ObjectUtils.disposeAllChildren(_AddRankingSprite);
         }
         _AddRankingSprite = null;
         _AddRankingBg = null;
         _AddRankingText = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
