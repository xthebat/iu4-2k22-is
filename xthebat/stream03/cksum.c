int chksum(uint8_t* buf, int size) {
	int result = 0;
	for (int k = 0; k < size; k++) {
		result += buf[k];
	}
	return result;
}