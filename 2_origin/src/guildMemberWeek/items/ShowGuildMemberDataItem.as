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
      
      public function GetTemplateInfo(TemplateID:int) : ItemTemplateInfo
      {
         return ItemManager.Instance.getTemplateById(TemplateID);
      }
      
      public function initView(Ranking:int) : void
      {
         _RankingText = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.MainFrame.left.ShowGuildMemberDataItem.RankingTxt");
         _RankingText.text = Ranking + "th";
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
         if(Ranking <= 3)
         {
            _RankingText.visible = false;
            _RankingBitmp = ComponentFactory.Instance.creat("toffilist.guildMemberWeektopThreeRink");
            _RankingBitmp.setFrame(Ranking);
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
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,30,30);
         sp.graphics.endFill();
         var cell:BaseCell = new BaseCell(sp,null,true,true);
         cell.tipDirctions = "7,6,2,1,5,4,0,3,6";
         cell.tipGapV = 10;
         cell.tipGapH = 10;
         cell.tipStyle = "core.GoodsTip";
         return cell;
      }
      
      public function initMember(MemberName:String, MemberContribute:String) : void
      {
         _MemberNameText.text = MemberName;
         _MemberContributeText.text = MemberContribute;
      }
      
      public function initAddPointBook(AddRanking:int) : void
      {
         _AddRankingText.text = String(AddRanking);
         _AddRankingBtn.tipData = LanguageMgr.GetTranslation("guildMemberWeek.MainDataLabel.CanGetPointBook") + _AddRankingText.text;
         _AddRankingBtn.tipGapH = 520;
      }
      
      public function initItemCell(GiftMessage:String) : void
      {
         var itemCell:* = null;
         var tempNumberShow:* = null;
         _itemCells = [];
         var Tgift:Array = GiftMessage.split(",");
         var i:int = 0;
         var L:int = Tgift.length;
         var Tpoint:Point = PositionUtils.creatPoint("guildMemberWeek.ShowGift.cellPos");
         var StartX:int = Tpoint.x;
         var StartY:int = Tpoint.y;
         var C:int = 0;
         for(i = 0; i < L; )
         {
            itemCell = creatItemCell();
            itemCell.buttonMode = true;
            itemCell.width = 30;
            itemCell.height = 30;
            itemCell.info = GetTemplateInfo(int(Tgift[i]));
            itemCell.buttonMode = true;
            itemCell.x = StartX + C * 35;
            itemCell.y = StartY;
            tempNumberShow = ComponentFactory.Instance.creatComponentByStylename("guildmemberweek.mainFrame.left.giftNumberShowTxt");
            tempNumberShow.text = "";
            if(Tgift[i + 1] != undefined)
            {
               tempNumberShow.text = Tgift[i + 1];
            }
            itemCell.addChild(tempNumberShow);
            _itemCells.push([itemCell,tempNumberShow,int(Tgift[i + 1])]);
            addChild(itemCell);
            C++;
            i = i + 2;
         }
      }
      
      private function disposeItemCell() : void
      {
         var L:int = 0;
         var i:int = 0;
         if(_itemCells)
         {
            L = _itemCells.length;
            i = 0;
            for(i = 0; i < L; )
            {
               ObjectUtils.disposeObject(_itemCells[i][1]);
               ObjectUtils.disposeObject(_itemCells[i][0]);
               _itemCells[i][0] = null;
               _itemCells[i][1] = null;
               _itemCells[i][2] = null;
               _itemCells[i] = null;
               i++;
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
