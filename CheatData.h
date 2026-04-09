#pragma once

class EnvData {
public:
	EnvData() = default;
	~EnvData() = default;

public:
	static const int STATUS_GAME_MMAP = 2;
	static const int STATUS_GAME_SMAP = 4;
	static const int BANBEN_1028 = 5;


public:
	bool is_valid_status();
	bool is_valid_banben();


public:
	int Status = 0;
	int BanBen = 0;
	int WugongNum = 0;
};


class PersonData : 
	protected std::tuple<int, std::string, int, int, int, 
		std::vector<int>> {
public:
	PersonData();
	~PersonData() = default;

public:
	enum {WUGONG_COUNT = 10};
public:
	static std::vector<std::pair<std::wstring, int>> GetPersons(bool filter_duiyou);
	static std::vector<int>& jyqxz_person_duiyous();

public:
	inline int& jyqxz_person_id() { return std::get<0>(*this); }
	inline std::string& jyqxz_person_name() { return std::get<1>(*this); }

	inline int& jyqxz_person_zizhi() { return std::get<2>(*this); }
	inline int& jyqxz_person_wuchang() { return std::get<3>(*this); }
	inline int& jyqxz_person_xiulian() { return std::get<4>(*this); }
	std::vector<int>& jyqxz_person_wugongs();
	std::vector<int> jyqxz_person_sort_wugongs();
	



private:
	void init();
};


class MiscData : 
	protected std::tuple<int, int, int, int, int>
{
public:
	MiscData();
	~MiscData() = default;

public:
	static std::vector<std::pair<std::wstring, int>> GetXiuLian(int code);
	static std::vector<std::pair<std::wstring, int>> GetWuGong(int pid, int code);

	static const std::unordered_map<int, std::wstring>& GetAllWuPin();
	static const std::unordered_map<int, std::wstring>& GetAllWuGong();


public:
	void read_config_file(const char* config_filepath);
	void write_config_file(const char* config_filepath);

public:
	inline int& jyqxz_trace_log()       { return std::get<0>(*this); }
	inline int& jyqxz_baoxi_dengji()    { return std::get<1>(*this); }
	inline int& jyqxz_baoxi_wugong()	{ return std::get<2>(*this); }
	inline int& jyqxz_baoxi_maxvalue()  { return std::get<3>(*this); }
	inline int& jyqxz_adjust_wupin()    { return std::get<4>(*this); }

private:
	void init();

};

class CheatData :
	protected std::tuple <EnvData, MiscData, PersonData> {
public:
	CheatData() = default;
	~CheatData() = default;
public:
	inline EnvData& env() { return std::get<0>(*this); }
	inline MiscData& misc() { return std::get<1>(*this); }
	inline PersonData& person() { return std::get<2>(*this); }


};